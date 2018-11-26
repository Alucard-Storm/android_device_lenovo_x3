#!/system/bin/sh
# Copyright (c) 2016, The Brobro Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, wouldn't fucking effect my life one way or the other.
#
# Post Boot From LG V10
# All thanks to XDA senior member warBeard_actual
#

# LGE_CHANGE_S, [LGE_DATA][LGP_DATA_TCPIP_NSRM]
targetProd=`getprop ro.product.name`
case "$targetProd" in
    "z2_lgu_kr" | "p1_lgu_kr" | "z2_skt_kr" | "p1_skt_kr" | "p1_kt_kr" | "p1_bell_ca" | "p1_rgs_ca" | "p1_tls_ca" | "pplus_kt_kr" | "p1a4wp_lgu_kr" )
    mkdir /data/connectivity/
    chown system.system /data/connectivity/
    chmod 775 /data/connectivity/
    mkdir /data/connectivity/nsrm/
    chown system.system /data/connectivity/nsrm/
    chmod 775 /data/connectivity/nsrm/
    cp /system/etc/dpm/nsrm/NsrmConfiguration.xml /data/connectivity/nsrm/
    chown system.system /data/connectivity/nsrm/NsrmConfiguration.xml
    chmod 775 /data/connectivity/nsrm/NsrmConfiguration.xml
    ;;
esac
# LGE_CHANGE_E, [LGE_DATA][LGP_DATA_TCPIP_NSRM]

target=`getprop ro.board.platform`
case "$target" in
    "msm8992")
        # disable thermal bcl hotplug to switch governor
        echo 0 > /sys/module/msm_thermal/core_control/enabled
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n disable > $mode
        done
        for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
        do
            bcl_hotplug_mask=`cat $hotplug_mask`
            echo 0 > $hotplug_mask
        done
        for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
        do
            bcl_soc_hotplug_mask=`cat $hotplug_soc_mask`
            echo 0 > $hotplug_soc_mask
        done
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n enable > $mode
        done

        # ensure at most one A57 is online when thermal hotplug is disabled
        echo 1 > /sys/devices/system/cpu/cpu4/online
        echo 1 > /sys/devices/system/cpu/cpu5/online
        # in case CPU4 is online, limit its frequency
        echo 1824000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        echo 1824000 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
        echo 384000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 384000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
        # Limit A57 max freq from msm_perf module in case CPU 4 is offline
        echo "4:1824000 5:1824000" > /sys/module/msm_performance/parameters/cpu_max_freq
        # configure governor settings for little cluster and set permissions ro
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
        echo "20000 960000:30000 1248000:60000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
        echo 20 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
        echo 10000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
        echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
        echo 600000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
        echo "35 864000:55 1248000:90" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
        echo 10000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
        echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/gpu_range_start_freq
        echo 180000000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/gpu_range_start_freq
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/gpu_range_start_freq
        chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/gpu_range_end_freq
        echo 600000000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/gpu_range_end_freq
        chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/interactive/gpu_range_end_freq

        # online CPU4
        echo 1 > /sys/devices/system/cpu/cpu4/online
        echo 1 > /sys/devices/system/cpu/cpu5/online
        # Best effort limiting for first time boot if msm_performance module is absent
        echo 1824000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        echo 1824000 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
        # configure governor settings for big cluster and set permissions ro
        echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
        echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
        echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
        echo "20000 960000:30000 1248000:40000 1536000:80000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
        echo 35 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
        echo 10000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
        echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
        echo 864000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
        echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
        echo "45 960000:60 1248000:90 1440000:95 1536000:99" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
        echo 10000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
        echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/gpu_range_start_freq
        echo 180000000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/gpu_range_start_freq
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/gpu_range_start_freq
        # chmod 777 /sys/devices/system/cpu/cpu4/cpufreq/interactive/gpu_range_end_freq
        echo 600000000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/gpu_range_end_freq
        # chmod 444 /sys/devices/system/cpu/cpu4/cpufreq/interactive/gpu_range_end_freq

        # Hot plug A57's, set&hold max freq for both.
        # Remove thermal-engine permissions, assign root
        # ownership in sysfs so Linux kernel has full
        # full hardware control.
        chown root.root /sys/devices/system/cpu/cpu4/online
        chown root.root /sys/devices/system/cpu/cpu5/online
        cat /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        cat /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
        chown root.root /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        chown root.root /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq

        # input/multi boost configuration
        echo 0:384000 > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 0 > /sys/module/cpu_boost/parameters/input_boost_ms
        echo 0:384000 > /sys/module/cpu_boost/parameters/multi_boost_freq

        # Setting b.L scheduler parameters
        echo 1 > /proc/sys/kernel/sched_migration_fixup
        echo 30 > /proc/sys/kernel/sched_small_task
        echo 20 > /proc/sys/kernel/sched_mostly_idle_load
        echo 3 > /proc/sys/kernel/sched_mostly_idle_nr_run
        echo 99 > /proc/sys/kernel/sched_upmigrate
        echo 85 > /proc/sys/kernel/sched_downmigrate
        echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
        echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
        #enable rps static configuration
        echo 8 >  /sys/class/net/rmnet_ipa0/queues/rx-0/rps_cpus
        # for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor
        # do
            # echo "bw_hwmon" > $devfreq_gov
        # done
        # Disable sched_boost
        echo 0 > /proc/sys/kernel/sched_boost

        # Disable retention and standalone power collapse
        echo "N" > /sys/module/lpm_levels/system/a53/cpu0/retention/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu1/retention/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu2/retention/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu3/retention/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu4/retention/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu5/retention/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu0/retention/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu1/retention/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu2/retention/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu3/retention/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu4/retention/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu5/retention/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu0/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu1/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu2/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu3/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu4/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu5/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu0/standalone_pc/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu1/standalone_pc/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu2/standalone_pc/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu3/standalone_pc/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu4/standalone_pc/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu5/standalone_pc/suspend_enabled

        # re-enable thermal and BCL hotplug
        echo 1 > /sys/module/msm_thermal/core_control/enabled
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n disable > $mode
        done
        for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
        do
            echo $bcl_hotplug_mask > $hotplug_mask
        done
        for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
        do
            echo $bcl_soc_hotplug_mask > $hotplug_soc_mask
        done
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n enable > $mode
        done

        # enable low power mode sleep
        echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
        # for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor
        # do
            # echo "simple_ondemand" > $devfreq_gov
        # done
        # restore max freq for cpu 4 & 5
        echo 1824000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        echo 1824000 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
        cat /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        cat /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
        echo 70 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/gpu_target_load
        echo 70 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/gpu_target_load
    ;;
esac

# I/O - Device storage
# echo "deadline" > /sys/block/mmcblk0/queue/scheduler
echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb
# echo 12 > /sys/block/mmcblk0/queue/iosched/fifo_batch
# echo 1 > /sys/block/mmcblk0/queue/iosched/front_merges
# echo 300 > /sys/block/mmcblk0/queue/iosched/read_expire
# echo 5000 > /sys/block/mmcblk0/queue/iosched/write_expire
# echo 2 > /sys/block/mmcblk0/queue/iosched/writes_starved

# I/O - Micro-SD
# echo "deadline" > /sys/block/mmcblk1/queue/scheduler
echo 1024 > /sys/block/mmcblk1/bdi/read_ahead_kb
# echo 12 > /sys/block/mmcblk1/queue/iosched/fifo_batch
# echo 1 > /sys/block/mmcblk1/queue/iosched/front_merges
# echo 100 > /sys/block/mmcblk1/queue/iosched/read_expire
# echo 5000 > /sys/block/mmcblk1/queue/iosched/write_expire
# echo 4 > /sys/block/mmcblk1/queue/iosched/writes_starved

# I/O - "FIFO" (optional), device storage
echo "noop" > /sys/block/mmcblk0/queue/scheduler
echo 0 > /sys/block/mmcblk0/queue/add_random
echo 0 > /sys/block/mmcblk0/queue/rotational
echo 1 > /sys/block/mmcblk0/queue/rq_affinity
echo 0 > /sys/block/mmcblk0/queue/nomerges
echo 256 > /sys/block/mmcblk0/queue/nr_requests

# I/O - "FIFO" (optional), Micro-SD
echo "noop" > /sys/block/mmcblk1/queue/scheduler
echo 0 > /sys/block/mmcblk1/queue/add_random
echo 0 > /sys/block/mmcblk1/queue/rotational
echo 1 > /sys/block/mmcblk1/queue/rq_affinity
echo 0 > /sys/block/mmcblk1/queue/nomerges
echo 256 > /sys/block/mmcblk1/queue/nr_requests

# Set RAM usage, minfree values, VM
echo 22149,30059,38760,58536,67238,79104 > /sys/module/lowmemorykiller/parameters/minfree
echo 100 > /proc/sys/vm/swappiness
echo 100 > /proc/sys/vm/vfs_cache_pressure
echo 200 > /proc/sys/vm/dirty_expire_centisecs
echo 500 > /proc/sys/vm/dirty_writeback_centisecs
echo 40 > /proc/sys/vm/dirty_ratio
echo 20 > /proc/sys/vm/dirty_background_ratio
# echo 1 > /proc/sys/vm/overcommit_memory
# echo 150 > /proc/sys/vm/overcommit_ratio
# echo 4096 > /proc/sys/vm/min_free_kbytes
# echo 1 > /proc/sys/vm/oom_kill_allocating_task
# Disable zRAM
swapoff /dev/block/zram0

# Tuning Transmission Control Protocols.
echo "cubic" > /proc/sys/net/ipv4/tcp_congestion_control
echo 1 > /proc/sys/net/ipv4/tcp_timestamps
echo 1 > /proc/sys/net/ipv4/tcp_sack
echo 1 > /proc/sys/net/ipv4/tcp_window_scaling

emmc_boot=`getprop ro.boot.emmc`
case "$emmc_boot"
    in "true")
        chown -h system /sys/devices/platform/rs300000a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300000a7.65536/sync_sts
        chown -h system /sys/devices/platform/rs300100a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300100a7.65536/sync_sts
    ;;
esac

# Post-setup services
case "$target" in
    "msm8994" | "msm8992")
        rm /data/system/perfd/default_values
        setprop ro.min_freq_0 384000
        setprop ro.min_freq_4 384000
        start perfd
    ;;
esac

case "$target" in
    "msm8226" | "msm8974" | "msm8610" | "apq8084" | "mpq8092" | "msm8610" | "msm8916" | "msm8994" | "msm8992")
        # Let kernel know our image version/variant/crm_version
        image_version="10:"
        image_version+=`getprop ro.build.id`
        image_version+=":"
        image_version+=`getprop ro.build.version.incremental`
        image_variant=`getprop ro.product.name`
        image_variant+="-"
        image_variant+=`getprop ro.build.type`
        oem_version=`getprop ro.build.version.codename`
        echo 10 > /sys/devices/soc0/select_image
        echo $image_version > /sys/devices/soc0/image_version
        echo $image_variant > /sys/devices/soc0/image_variant
        echo $oem_version > /sys/devices/soc0/image_crm_version
        ;;
esac

# change GPU governor and parameters
echo "simple_ondemand" > /sys/devices/soc.0/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/governor
# chmod 777 /sys/devices/soc.0/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/target_freq
# echo 180000000 > /sys/devices/soc.0/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/target_freq
# chmod 444 /sys/devices/soc.0/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/target_freq
# echo 5 > /sys/devices/soc.0/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/polling_interval
