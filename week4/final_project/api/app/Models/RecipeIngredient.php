<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RecipeIngredient extends Model
{
    use HasFactory;
    protected $fillable = ['ingredient', 'recipe_id'];
}
