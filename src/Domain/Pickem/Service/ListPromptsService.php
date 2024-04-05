<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

use App\Domain\Pickem\Repository\PromptRepository;
use Psr\Log\LoggerInterface;

final class ListPromptsService
{
    protected $promptRepository;

    public function __construct(LoggerInterface $logger, PromptRepository $promptRepository)
    {
        $this->logger = $logger;
        $this->promptRepository = $promptRepository;
    }

    public function run(bool $open)
    {
        if($open)
        {
            $promptList = $this->promptRepository->findAllOpen();
        }
        else
        {
            $promptList = $this->promptRepository->findAll();
        }

        $this->logger->debug('Prompt list was viewed.');

        return $promptList;
    }
}
