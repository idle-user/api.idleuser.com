<?php
declare(strict_types=1);

namespace App\Domain\Traffic\Data;

use JsonSerializable;

class Traffic implements JsonSerializable
{
    private $id;
    private $domain_id;
    private $request_id;
    private $user_agent_id;
    private $ip_id;
    private $response_code;
    private $response_updated;
    private $created;

    public function __construct()
    {
    }

    public function getId()
    {
        return $this->id;
    }

    public function setResponseCode($responseCode)
    {
        $this->response_code = $responseCode;
    }

    public static function withRow(array $row)
    {
        $instance = new self();
        $instance->fill($row);
        return $instance;
    }

    public function jsonSerialize()
    {
        return [
            'id' => $this->id,
            'domain_id' => $this->domain_id,
            'request_id' => $this->request_id,
            'user_agent_id' => $this->user_agent_id,
            'ip_id' => $this->ip_id,
            'response_code' => $this->response_code,
            'response_updated' => $this->response_updated,
            'created' => $this->created,
        ];
    }

    protected function fill(array $row)
    {
        $this->id = $row['uuid'];
        $this->domain_id = $row['domain_id'];
        $this->request_id = $row['request_id'];
        $this->user_agent_id = $row['user_agent_id'];
        $this->ip_id = $row['ip_id'];
        $this->response_code = $row['response_code'];
        $this->response_updated = $row['response_updated'];
        $this->created = $row['created'];
    }
}
