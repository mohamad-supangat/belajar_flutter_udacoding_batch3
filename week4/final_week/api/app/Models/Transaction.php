<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Transaction extends Model
{
  use HasFactory, SoftDeletes;

  protected $fillable = [
    'title', 'description', 'type', 'amount', 'user_id'
  ];

  function categories()
  {
    return $this->belongsToMany(\App\Models\Category::class);
  }
  function scopeFilterUser($query)
  {
    return $query->where('user_id', auth()->id());
  }
}
