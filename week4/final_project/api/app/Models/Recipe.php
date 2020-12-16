<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recipe extends Model
{
    use HasFactory;

    protected $fillable = [
        'title', 'description', 'user_id', 'image'
    ];

    function user()
    {
        return $this->belongsTo(User::class);
    }

    function categories()
    {
        return $this->belongsToMany(\App\Models\Category::class);
    }

    function steps()
    {
        return $this->hasMany(RecipeStep::class);
    }

    function ingredients()
    {
        return $this->hasMany(RecipeIngredient::class);
    }
}
