+++
title = "RSoC 2026: EEVDF Scheduler"
author = "Akshit Gaur"
date = "2026-05-30"
+++

The EEVDF scheduler was successfully implemented to replace the DWRR scheduler. It features more dynamic calculations than the simple DWRR which should make the system a lot more fair in CPU time distribution. The new scheduler is more stable than the old one and improved the Pixelcannon demo performance by around 200 FPS! (do note that the implementation for EEVDF has not yet gone through optimisation phase). Expect the system to be more stable and faster now!

A detailed report will be posted after the optimization phase.

# Comparing two tasks with different priorities

## DWRR
    ```
    Process 1: Priority -10 (HIGH)
    Process 2: Priority 10 (LOW)
    Running for 10 seconds to measure CPU share...
    
    [Child 1] Priority set to: -10
    [HIGH_PRIO] Started with priority -10 (NORMAL)
    [HIGH_PRIO] Priority: -10 | Elapsed: 1s | Iterations/sec: 1620000000 | Total: 1620000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 2s | Iterations/sec: 2550000000 | Total: 4170000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 3s | Iterations/sec: 2570000000 | Total: 6740000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 4s | Iterations/sec: 2560000000 | Total: 9300000000
    [Parent] Waiting for both children to complete...
    
    [HIGH_PRIO] Priority: -10 | Elapsed: 5s | Iterations/sec: 2550000000 | Total: 11850000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 6s | Iterations/sec: 2560000000 | Total: 14410000000
    [Child 2] Priority set to: 10
    [LOW_PRIO] Started with priority 10 (NORMAL)
    [HIGH_PRIO] Priority: -10 | Elapsed: 7s | Iterations/sec: 2380000000 | Total: 16790000000
    [LOW_PRIO] Priority: 10 | Elapsed: 1s | Iterations/sec: 190000000 | Total: 190000000
    [LOW_PRIO] Priority: 10 | Elapsed: 2s | Iterations/sec: 380000000 | Total: 570000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 8s | Iterations/sec: 2180000000 | Total: 18970000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 9s | Iterations/sec: 2180000000 | Total: 21150000000
    [LOW_PRIO] Priority: 10 | Elapsed: 3s | Iterations/sec: 380000000 | Total: 950000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 10s | Iterations/sec: 2210000000 | Total: 23360000000
    [LOW_PRIO] Priority: 10 | Elapsed: 4s | Iterations/sec: 350000000 | Total: 1300000000
    [HIGH_PRIO] Completed. Total iterations: 23360000000
    [HIGH_PRIO] AVERAGE iterations/sec: 2336000000
    [LOW_PRIO] Priority: 10 | Elapsed: 5s | Iterations/sec: 2560000000 | Total: 3860000000
    [LOW_PRIO] Priority: 10 | Elapsed: 6s | Iterations/sec: 2570000000 | Total: 6430000000
    [LOW_PRIO] Priority: 10 | Elapsed: 7s | Iterations/sec: 2560000000 | Total: 8990000000
    [LOW_PRIO] Priority: 10 | Elapsed: 8s | Iterations/sec: 2560000000 | Total: 11550000000
    [LOW_PRIO] Priority: 10 | Elapsed: 9s | Iterations/sec: 2560000000 | Total: 14110000000
    [LOW_PRIO] Priority: 10 | Elapsed: 10s | Iterations/sec: 2560000000 | Total: 16670000000
    [LOW_PRIO] Completed. Total iterations: 16670000000
    [LOW_PRIO] AVERAGE iterations/sec: 1667000000
    
    [Parent] Both processes completed.
    
    === SUMMARY ===
    HIGH Priority Total Iterations: 23360000000
    LOW Priority Total Iterations:  16670000000
    
    => RATIO (HIGH / LOW): 1.401 x
    ```

Note here that the low-prio task started significantly after the high-prio one and thus receives uninterrupted time at the end, which skews the ratio.

## EEVDF

    ```
    Process 1: Priority -10 (HIGH)
    Process 2: Priority 10 (LOW)
    Running for 10 seconds to measure CPU share...
    
    [Child 1] Priority set to: -10
    [HIGH_PRIO] Started with priority -10 (NORMAL)
    [Parent] Waiting for both children to complete...
    [Child 2] Priority set to: 10
    [LOW_PRIO] Started with priority 10 (NORMAL)
    
    [HIGH_PRIO] Priority: -10 | Elapsed: 1s | Iterations/sec: 2280000000 | Total: 2280000000
    [LOW_PRIO] Priority: 10 | Elapsed: 1s | Iterations/sec: 70000000 | Total: 70000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 2s | Iterations/sec: 2510000000 | Total: 4790000000
    [LOW_PRIO] Priority: 10 | Elapsed: 2s | Iterations/sec: 30000000 | Total: 100000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 3s | Iterations/sec: 2500000000 | Total: 7290000000
    [LOW_PRIO] Priority: 10 | Elapsed: 3s | Iterations/sec: 30000000 | Total: 130000000
    [LOW_PRIO] Priority: 10 | Elapsed: 4s | Iterations/sec: 30000000 | Total: 160000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 4s | Iterations/sec: 2500000000 | Total: 9790000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 5s | Iterations/sec: 2470000000 | Total: 12260000000
    [LOW_PRIO] Priority: 10 | Elapsed: 5s | Iterations/sec: 60000000 | Total: 220000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 6s | Iterations/sec: 2490000000 | Total: 14750000000
    [LOW_PRIO] Priority: 10 | Elapsed: 6s | Iterations/sec: 30000000 | Total: 250000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 7s | Iterations/sec: 2520000000 | Total: 17270000000
    [LOW_PRIO] Priority: 10 | Elapsed: 7s | Iterations/sec: 30000000 | Total: 280000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 8s | Iterations/sec: 2520000000 | Total: 19790000000
    [LOW_PRIO] Priority: 10 | Elapsed: 8s | Iterations/sec: 30000000 | Total: 310000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 9s | Iterations/sec: 2530000000 | Total: 22320000000
    [LOW_PRIO] Priority: 10 | Elapsed: 9s | Iterations/sec: 30000000 | Total: 340000000
    [HIGH_PRIO] Priority: -10 | Elapsed: 10s | Iterations/sec: 2520000000 | Total: 24840000000
    [HIGH_PRIO] Completed. Total iterations: 24840000000
    [HIGH_PRIO] AVERAGE iterations/sec: 2484000000
    [LOW_PRIO] Priority: 10 | Elapsed: 10s | Iterations/sec: 40000000 | Total: 380000000
    [LOW_PRIO] Completed. Total iterations: 380000000
    [LOW_PRIO] AVERAGE iterations/sec: 38000000
    
    [Parent] Both processes completed.
    
    === SUMMARY ===
    HIGH Priority Total Iterations: 24840000000
    LOW Priority Total Iterations:  380000000
    
    => RATIO (HIGH / LOW): 65.368 x
    ```

EEVDF works as expected.


# Pixelcannon

## DWRR

1.  With only Pixelcannon running, it shows ~1900 fps
2.  With one CPU hogging application (for example, a while true loop), ~1500 fps.
3.  With 2 CPU hoggers, ~1200 fps


## EEVDF

1.  Only Pixelcannon, ~1900 fps.
2.  With 1 CPU hogger, ~1700 fps.
3.  With 2 CPU hoggers, ~1400 fps.

