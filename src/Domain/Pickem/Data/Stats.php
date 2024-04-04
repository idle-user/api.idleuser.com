<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Data;

use JsonSerializable;

class Stats implements JsonSerializable
{
    private $user_id;
    private $prompts_created;
    private $picks_made;
    private $picks_correct;
    private $picks_correct_others;
    private $last_prompt_date;
    private $prompts_created_today;
    private $created_at;
    private $updated_at;

    public function __construct()
    {
    }

    public static function create(): Stats
    {
        return new self();
    }

    public static function withRow(array $row)
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function getUserId(): int
    {
        return $this->user_id;
    }

    public function getPromptsCreated(): int
    {
        return $this->prompts_created;
    }

    public function getPicksMade(): int
    {
        return $this->picks_made;
    }

    public function getPicksCorrect(): int
    {
        return $this->picks_correct;
    }

    public function getPicksCorrectOthers(): int
    {
        return $this->picks_correct_others;
    }

    public function getLastPromptDate(): ?string
    {
        return $this->last_prompt_date;
    }

    public function getPromptsCreatedToday(): int
    {
        return $this->prompts_created_today;
    }

    public function getCreatedAt(): string
    {
        return $this->created_at;
    }

    public function getUpdatedAt(): string
    {
        return $this->updated_at;
    }

    public function setUserId(int $userId): Stats
    {
        $this->user_id = $userId;
        return $this;
    }

    public function incrementPicks(): Stats
    {
        $this->picks_made++;
        return $this;
    }

    public function incrementPromptsCreated(): Stats
    {
        $currentDate = date("Y-m-d");
        if ($this->last_prompt_date !== $currentDate) {
            $this->last_prompt_date = $currentDate;
            $this->prompts_created_today = 0;
        }
        $this->prompts_created++;
        $this->prompts_created_today++;

        return $this;
    }

    public function incrementPicksCorrect(bool $isPromptCreator): Stats
    {
        $this->picks_correct++;
        if (!$isPromptCreator) {
            $this->picks_correct_others++;
        }

        return $this;
    }

    public function jsonSerialize()
    {
        return [
            'user_id' => $this->user_id,
            'prompts_created' => $this->prompts_created,
            'picks_made' => $this->picks_made,
            'picks_correct' => $this->picks_correct,
            'picks_correct_others' => $this->picks_correct_others,
            'last_prompt_date' => $this->last_prompt_date,
            'prompts_created_today' => $this->prompts_created_today,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }

    protected function fill(array $row)
    {
        $this->user_id = $row['user_id'];
        $this->prompts_created = $row['prompts_created'];
        $this->picks_made = $row['picks_made'];
        $this->picks_correct = $row['picks_correct'];
        $this->picks_correct_others = $row['picks_correct_others'];
        $this->last_prompt_date = $row['last_prompt_date'];
        $this->prompts_created_today = $row['prompts_created_today'];
        $this->created_at = $row['created_at'];
        $this->updated_at = $row['updated_at'];
    }

}
