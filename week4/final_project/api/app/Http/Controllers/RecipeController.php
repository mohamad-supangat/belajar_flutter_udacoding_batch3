<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Recipe;
use Illuminate\Http\Request;

class RecipeController extends Controller
{
    public function action(Request $request)
    {
        $request->validate([
            'title'         => 'required',
            'description'   => '',
            'image'         => 'image',
            'categories'    => 'array|required',
            'steps'         => 'array|required|min:1',
            'ingredients'   => 'array|required|min:1'
        ]);

        if ($request->image) {
            $image = $request->file('image')->store('recipe_images');
        }

        $recipe = Recipe::updateOrCreate([
            'id'                => $request->id,
        ], [
            'title'             => $request->title,
            'description'       => $request->description,
            'image'             => $image ?? null,
            'user_id'           => auth()->id(),
        ]);

        /* categories syncronasion */
        $categories = [];
        if ($request->categories && count($request->categories) > 0) {
            foreach ($request->categories as $category) {
                $categories[] = Category::updateOrCreate([
                    'name'    => ucwords(strtolower($category)),
                ])->id;
            }
        }
        if (count($categories) > 0) {
            $recipe->categories()->sync($categories);
        }

        $recipe->ingredients()->delete();
        if ($request->ingredients && count($request->ingredients) > 0) {
            foreach ($request->ingredients as $ingredient) {
                $recipe->ingredients()->create([
                    'ingredient' => $ingredient
                ]);
            }
        }

        $recipe->steps()->delete();
        if ($request->steps && count($request->steps) > 0) {
            foreach ($request->steps as $step) {
                $recipe->steps()->create([
                    'step' => $step
                ]);
            }
        }

        return response()->json([
            'status'        => $recipe ? true : false,
            'recipe'        => Recipe::with(['categories', 'steps', 'ingredients'])->find($recipe->id),
        ]);
    }


    public function lists(Request $request)
    {
        $modelRecipe = Recipe::orderBy('title', 'ASC');

        $paginateData = $modelRecipe->simplePaginate(15);
        $paginateData->getCollection()->transform(function ($recipe) {
            return [
                'id'            => $recipe->id,
                'title'         => $recipe->title,
                'image'         => $recipe->image != null ? url('uploads', $recipe->image) : null,
                'created_by'    => $recipe->user->name,
                'categories'    => $recipe->categories->pluck('name'),
                'description'   => $recipe->description,
                'ingredients'   => $recipe->ingredients()->orderBy('id', 'ASC')->get()->pluck('ingredient'),
                'steps'         => $recipe->steps()->orderBy('id', 'ASC')->get()->pluck('step'),
            ];
        });


        return response()->json([
            'status'    => true,
            'recipes'   => $paginateData
        ]);
    }
}
