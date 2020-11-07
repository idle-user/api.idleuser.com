<?php
declare(strict_types=1);

namespace App\Domain\Matches\Data;

use JsonSerializable;

class Superstar implements JsonSerializable
{
    private $id;
    private $name;
    private $brand_id;
    private $height;
    private $weight;
    private $hometown;
    private $dob;
    private $signature_move;
    private $page_url;
    private $image_url;
    private $bio;
    private $twitter_id;
    private $twitter_username;
    private $last_updated;

    public function __construct()
    {
    }

    public static function withRow(array $row)
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'brand_id' => $this->brand_id,
            'height' => $this->height,
            'weight' => $this->weight,
            'hometown' => $this->hometown,
            'dob' => $this->dob,
            'signature_move' => $this->signature_move,
            'page_url' => $this->page_url,
            'image_url' => $this->image_url,
            'bio' => $this->bio,
            'twitter_id' => $this->twitter_id,
            'twitter_username' => $this->twitter_username,
            'last_updated' => $this->last_updated,
        ];
    }

    protected function fill(array $row)
    {
        $this->id = $row['id'];
        $this->name = $row['name'];
        $this->brand_id = $row['brand_id'];
        $this->height = $row['height'];
        $this->weight = $row['weight'];
        $this->hometown = $row['hometown'];
        $this->dob = $row['dob'];
        $this->signature_move = $row['signature_move'];
        $this->page_url = $row['page_url'];
        $this->image_url = $row['image_url'];
        $this->bio = $row['bio'];
        $this->twitter_id = $row['twitter_id'];
        $this->twitter_username = $row['twitter_username'];
        $this->last_updated = $row['last_updated'];
    }
}
