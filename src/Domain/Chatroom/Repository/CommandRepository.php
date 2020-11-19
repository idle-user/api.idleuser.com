<?php
declare(strict_types=1);

namespace App\Domain\Chatroom\Repository;

use App\Domain\Database;
use App\Domain\Chatroom\Data\Command;
use App\Domain\Chatroom\Exception\CommandAlreadyExistsException;
use App\Domain\Chatroom\Exception\CommandNotFoundException;

use PDOException;

class CommandRepository
{
    private $db;

    public function __construct(Database $db)
    {
        $this->db = $db;
    }

    public function findAll()
    {
        $sql = 'SELECT * FROM chatroom_command';
        $stmt = $this->db->query($sql);
        $ret = [];
        while ($row = $stmt->fetch()) {
            $ret[] = Command::withRow($row);
        }
        if (empty($ret)) {
            throw new CommandNotFoundException();
        }
        return $ret;
    }

    public function findById($id)
    {
        $sql = 'SELECT * FROM chatroom_command WHERE id=?';
        $stmt = $this->db->query($sql, [$id]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new CommandNotFoundException();
        }
        return Command::withRow($row);
    }

    public function findByCommand($command)
    {
        $sql = 'SELECT * FROM chatroom_command WHERE command=?';
        $stmt = $this->db->query($sql, [$command]);
        $row = $stmt->fetch();
        if (!$row) {
            throw new CommandNotFoundException();
        }
        return Command::withRow($row);
    }

    public function add(Command $command)
    {
        $sql = 'INSERT INTO chatroom_command (command, response, description, last_updated) VALUES (?, ?, ?, NOW())';
        $args = [$command->getCommand(), $command->getResponse(), $command->getDescription()];

        try {
            $this->db->query($sql, $args);
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                throw new CommandAlreadyExistsException();
            } else {
                throw $e;
            }
        }

        $commandId = $this->db->lastInsertId();

        return $commandId;
    }

    public function update(Command $command)
    {
        $sql = 'INSERT INTO chatroom_command (command, response, description, last_updated) VALUES (?, ?, ?, NOW())
                ON DUPLICATE KEY UPDATE response=?, description=?, last_updated=NOW();';
        $args = [
            $command->getCommand(),
            $command->getResponse(),
            $command->getDescription(),
            $command->getResponse(),
            $command->getDescription(),
        ];

        $this->db->query($sql, $args);

        $commandId = $this->db->lastInsertId();

        return $commandId;
    }
}
