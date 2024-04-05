<?php
declare(strict_types=1);

namespace App\Domain\Pickem\Service;

use App\Domain\Pickem\Repository\ChoiceRepository;
use App\Domain\Pickem\Repository\PickRepository;
use App\Domain\Pickem\Repository\PromptRepository;
use App\Domain\Pickem\Repository\StatsRepository;
use Psr\Log\LoggerInterface;

abstract class PickemService
{
    protected PromptRepository $promptRepository;
    protected ChoiceRepository $choiceRepository;
    protected PickRepository $pickRepository;
    protected StatsRepository $statsRepository;

    public function __construct(
        LoggerInterface  $logger,
        PromptRepository $promptRepository,
        ChoiceRepository $choiceRepository,
        PickRepository   $pickRepository,
        StatsRepository  $statsRepository
    )
    {
        $this->logger = $logger;
        $this->promptRepository = $promptRepository;
        $this->choiceRepository = $choiceRepository;
        $this->pickRepository = $pickRepository;
        $this->statsRepository = $statsRepository;
    }
}
