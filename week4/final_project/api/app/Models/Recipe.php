<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recipe extends Model
{
  use HasFactory;

  protected $fillable = [
    'title', 'description', 'user_id'
  ];

  function categories()
  {
    return $this->belongsToMany(\App\Models\Category::class);
  }
}
