(module
  (type $t0 (func (param i32 i32 i32) (result i32)))
  (type $t1 (func (param i32 i64 i32) (result i64)))
  (type $t2 (func (param i32)))
  (type $t3 (func (param i32 i64 i32 i32) (result i32)))
  (type $t4 (func (param i32) (result i32)))
  (type $t5 (func (param i32 i32 i32 i32) (result i32)))
  (type $t6 (func (param i32 i32) (result i32)))
  (type $t7 (func))
  (type $t8 (func (result i32)))
  (import "wasi_snapshot_preview1" "proc_exit" (func $__wasi_proc_exit (type $t2)))
  (import "wasi_snapshot_preview1" "fd_seek" (func $__wasi_fd_seek (type $t3)))
  (import "wasi_snapshot_preview1" "fd_close" (func $__wasi_fd_close (type $t4)))
  (import "wasi_snapshot_preview1" "fd_write" (func $__wasi_fd_write (type $t5)))
  (import "wasi_snapshot_preview1" "fd_fdstat_get" (func $__wasi_fd_fdstat_get (type $t6)))
  (func $__wasm_call_ctors (type $t7))
  (func $_start (type $t7)
    (local $l0 i32)
    call $__wasm_call_ctors
    call $__original_main
    local.set $l0
    call $__wasm_call_dtors
    block $B0
      local.get $l0
      i32.eqz
      br_if $B0
      local.get $l0
      call $__wasi_proc_exit
      unreachable
    end)
  (func $__original_main (type $t8) (result i32)
    (local $l0 i32) (local $l1 i32) (local $l2 i32) (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32)
    global.get $g0
    local.set $l0
    i32.const 16
    local.set $l1
    local.get $l0
    local.get $l1
    i32.sub
    local.set $l2
    local.get $l2
    global.set $g0
    i32.const 0
    local.set $l3
    i32.const 1024
    local.set $l4
    local.get $l2
    local.get $l3
    i32.store offset=12
    local.get $l4
    call $puts
    drop
    i32.const 16
    local.set $l5
    local.get $l2
    local.get $l5
    i32.add
    local.set $l6
    local.get $l6
    global.set $g0
    local.get $l3
    return)
  (func $dummy (type $t7))
  (func $__wasm_call_dtors (type $t7)
    call $dummy
    call $__stdio_exit)
  (func $__lseek (type $t1) (param $p0 i32) (param $p1 i64) (param $p2 i32) (result i64)
    (local $l3 i32)
    global.get $g0
    i32.const 16
    i32.sub
    local.tee $l3
    global.set $g0
    block $B0
      block $B1
        local.get $p0
        local.get $p1
        local.get $p2
        i32.const 255
        i32.and
        local.get $l3
        i32.const 8
        i32.add
        call $__wasi_fd_seek
        local.tee $p0
        i32.eqz
        br_if $B1
        i32.const 0
        i32.const 70
        local.get $p0
        local.get $p0
        i32.const 76
        i32.eq
        select
        i32.store offset=1168
        i64.const -1
        local.set $p1
        br $B0
      end
      local.get $l3
      i64.load offset=8
      local.set $p1
    end
    local.get $l3
    i32.const 16
    i32.add
    global.set $g0
    local.get $p1)
  (func $__stdio_seek (type $t1) (param $p0 i32) (param $p1 i64) (param $p2 i32) (result i64)
    local.get $p0
    i32.load offset=56
    local.get $p1
    local.get $p2
    call $__lseek)
  (func $__ofl_lock (type $t8) (result i32)
    i32.const 2216)
  (func $__stdio_exit (type $t7)
    (local $l0 i32) (local $l1 i32) (local $l2 i32)
    block $B0
      call $__ofl_lock
      i32.load
      local.tee $l0
      i32.eqz
      br_if $B0
      loop $L1
        block $B2
          local.get $l0
          i32.load offset=20
          local.get $l0
          i32.load offset=24
          i32.eq
          br_if $B2
          local.get $l0
          i32.const 0
          i32.const 0
          local.get $l0
          i32.load offset=32
          call_indirect (type $t0) $T0
          drop
        end
        block $B3
          local.get $l0
          i32.load offset=4
          local.tee $l1
          local.get $l0
          i32.load offset=8
          local.tee $l2
          i32.eq
          br_if $B3
          local.get $l0
          local.get $l1
          local.get $l2
          i32.sub
          i64.extend_i32_s
          i32.const 1
          local.get $l0
          i32.load offset=36
          call_indirect (type $t1) $T0
          drop
        end
        local.get $l0
        i32.load offset=52
        local.tee $l0
        br_if $L1
      end
    end
    block $B4
      i32.const 0
      i32.load offset=2220
      local.tee $l0
      i32.eqz
      br_if $B4
      block $B5
        local.get $l0
        i32.load offset=20
        local.get $l0
        i32.load offset=24
        i32.eq
        br_if $B5
        local.get $l0
        i32.const 0
        i32.const 0
        local.get $l0
        i32.load offset=32
        call_indirect (type $t0) $T0
        drop
      end
      local.get $l0
      i32.load offset=4
      local.tee $l1
      local.get $l0
      i32.load offset=8
      local.tee $l2
      i32.eq
      br_if $B4
      local.get $l0
      local.get $l1
      local.get $l2
      i32.sub
      i64.extend_i32_s
      i32.const 1
      local.get $l0
      i32.load offset=36
      call_indirect (type $t1) $T0
      drop
    end
    block $B6
      i32.const 0
      i32.load offset=1152
      local.tee $l0
      i32.eqz
      br_if $B6
      block $B7
        local.get $l0
        i32.load offset=20
        local.get $l0
        i32.load offset=24
        i32.eq
        br_if $B7
        local.get $l0
        i32.const 0
        i32.const 0
        local.get $l0
        i32.load offset=32
        call_indirect (type $t0) $T0
        drop
      end
      local.get $l0
      i32.load offset=4
      local.tee $l1
      local.get $l0
      i32.load offset=8
      local.tee $l2
      i32.eq
      br_if $B6
      local.get $l0
      local.get $l1
      local.get $l2
      i32.sub
      i64.extend_i32_s
      i32.const 1
      local.get $l0
      i32.load offset=36
      call_indirect (type $t1) $T0
      drop
    end
    block $B8
      i32.const 0
      i32.load offset=2220
      local.tee $l0
      i32.eqz
      br_if $B8
      block $B9
        local.get $l0
        i32.load offset=20
        local.get $l0
        i32.load offset=24
        i32.eq
        br_if $B9
        local.get $l0
        i32.const 0
        i32.const 0
        local.get $l0
        i32.load offset=32
        call_indirect (type $t0) $T0
        drop
      end
      local.get $l0
      i32.load offset=4
      local.tee $l1
      local.get $l0
      i32.load offset=8
      local.tee $l2
      i32.eq
      br_if $B8
      local.get $l0
      local.get $l1
      local.get $l2
      i32.sub
      i64.extend_i32_s
      i32.const 1
      local.get $l0
      i32.load offset=36
      call_indirect (type $t1) $T0
      drop
    end)
  (func $__towrite (type $t4) (param $p0 i32) (result i32)
    (local $l1 i32)
    local.get $p0
    local.get $p0
    i32.load offset=60
    local.tee $l1
    i32.const -1
    i32.add
    local.get $l1
    i32.or
    i32.store offset=60
    block $B0
      local.get $p0
      i32.load
      local.tee $l1
      i32.const 8
      i32.and
      i32.eqz
      br_if $B0
      local.get $p0
      local.get $l1
      i32.const 32
      i32.or
      i32.store
      i32.const -1
      return
    end
    local.get $p0
    i64.const 0
    i64.store offset=4 align=4
    local.get $p0
    local.get $p0
    i32.load offset=40
    local.tee $l1
    i32.store offset=24
    local.get $p0
    local.get $l1
    i32.store offset=20
    local.get $p0
    local.get $l1
    local.get $p0
    i32.load offset=44
    i32.add
    i32.store offset=16
    i32.const 0)
  (func $fwrite (type $t5) (param $p0 i32) (param $p1 i32) (param $p2 i32) (param $p3 i32) (result i32)
    (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32) (local $l8 i32) (local $l9 i32) (local $l10 i32)
    local.get $p2
    local.get $p1
    i32.mul
    local.set $l4
    block $B0
      block $B1
        local.get $p3
        i32.load offset=16
        local.tee $l5
        br_if $B1
        i32.const 0
        local.set $l5
        local.get $p3
        call $__towrite
        br_if $B0
        local.get $p3
        i32.load offset=16
        local.set $l5
      end
      block $B2
        local.get $l5
        local.get $p3
        i32.load offset=20
        local.tee $l6
        i32.sub
        local.get $l4
        i32.ge_u
        br_if $B2
        local.get $p3
        local.get $p0
        local.get $l4
        local.get $p3
        i32.load offset=32
        call_indirect (type $t0) $T0
        local.set $l5
        br $B0
      end
      i32.const 0
      local.set $l7
      block $B3
        block $B4
          local.get $p3
          i32.load offset=64
          i32.const 0
          i32.ge_s
          br_if $B4
          local.get $l4
          local.set $l5
          br $B3
        end
        local.get $p0
        local.get $l4
        i32.add
        local.set $l8
        i32.const 0
        local.set $l7
        i32.const 0
        local.set $l5
        loop $L5
          block $B6
            local.get $l4
            local.get $l5
            i32.add
            br_if $B6
            local.get $l4
            local.set $l5
            br $B3
          end
          local.get $l8
          local.get $l5
          i32.add
          local.set $l9
          local.get $l5
          i32.const -1
          i32.add
          local.tee $l10
          local.set $l5
          local.get $l9
          i32.const -1
          i32.add
          i32.load8_u
          i32.const 10
          i32.ne
          br_if $L5
        end
        local.get $p3
        local.get $p0
        local.get $l4
        local.get $l10
        i32.add
        i32.const 1
        i32.add
        local.tee $l7
        local.get $p3
        i32.load offset=32
        call_indirect (type $t0) $T0
        local.tee $l5
        local.get $l7
        i32.lt_u
        br_if $B0
        local.get $l10
        i32.const -1
        i32.xor
        local.set $l5
        local.get $l8
        local.get $l10
        i32.add
        i32.const 1
        i32.add
        local.set $p0
        local.get $p3
        i32.load offset=20
        local.set $l6
      end
      local.get $l6
      local.get $p0
      local.get $l5
      call $memcpy
      drop
      local.get $p3
      local.get $p3
      i32.load offset=20
      local.get $l5
      i32.add
      i32.store offset=20
      local.get $l7
      local.get $l5
      i32.add
      local.set $l5
    end
    block $B7
      local.get $l5
      local.get $l4
      i32.ne
      br_if $B7
      local.get $p2
      i32.const 0
      local.get $p1
      select
      return
    end
    local.get $l5
    local.get $p1
    i32.div_u)
  (func $fputs (type $t6) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l2 i32)
    local.get $p0
    call $strlen
    local.set $l2
    i32.const -1
    i32.const 0
    local.get $l2
    local.get $p0
    i32.const 1
    local.get $l2
    local.get $p1
    call $fwrite
    i32.ne
    select)
  (func $__overflow (type $t6) (param $p0 i32) (param $p1 i32) (result i32)
    (local $l2 i32) (local $l3 i32) (local $l4 i32)
    global.get $g0
    i32.const 16
    i32.sub
    local.tee $l2
    global.set $g0
    local.get $l2
    local.get $p1
    i32.store8 offset=15
    block $B0
      block $B1
        local.get $p0
        i32.load offset=16
        local.tee $l3
        br_if $B1
        i32.const -1
        local.set $l3
        local.get $p0
        call $__towrite
        br_if $B0
        local.get $p0
        i32.load offset=16
        local.set $l3
      end
      block $B2
        local.get $p0
        i32.load offset=20
        local.tee $l4
        local.get $l3
        i32.eq
        br_if $B2
        local.get $p0
        i32.load offset=64
        local.get $p1
        i32.const 255
        i32.and
        local.tee $l3
        i32.eq
        br_if $B2
        local.get $p0
        local.get $l4
        i32.const 1
        i32.add
        i32.store offset=20
        local.get $l4
        local.get $p1
        i32.store8
        br $B0
      end
      i32.const -1
      local.set $l3
      local.get $p0
      local.get $l2
      i32.const 15
      i32.add
      i32.const 1
      local.get $p0
      i32.load offset=32
      call_indirect (type $t0) $T0
      i32.const 1
      i32.ne
      br_if $B0
      local.get $l2
      i32.load8_u offset=15
      local.set $l3
    end
    local.get $l2
    i32.const 16
    i32.add
    global.set $g0
    local.get $l3)
  (func $puts (type $t4) (param $p0 i32) (result i32)
    block $B0
      local.get $p0
      i32.const 1040
      call $fputs
      i32.const 0
      i32.ge_s
      br_if $B0
      i32.const -1
      return
    end
    block $B1
      i32.const 0
      i32.load offset=1104
      i32.const 10
      i32.eq
      br_if $B1
      i32.const 0
      i32.load offset=1060
      local.tee $p0
      i32.const 0
      i32.load offset=1056
      i32.eq
      br_if $B1
      i32.const 0
      local.get $p0
      i32.const 1
      i32.add
      i32.store offset=1060
      local.get $p0
      i32.const 10
      i32.store8
      i32.const 0
      return
    end
    i32.const 1040
    i32.const 10
    call $__overflow
    i32.const 31
    i32.shr_s)
  (func $close (type $t4) (param $p0 i32) (result i32)
    block $B0
      local.get $p0
      call $__wasi_fd_close
      local.tee $p0
      br_if $B0
      i32.const 0
      return
    end
    i32.const 0
    local.get $p0
    i32.store offset=1168
    i32.const -1)
  (func $__stdio_close (type $t4) (param $p0 i32) (result i32)
    local.get $p0
    i32.load offset=56
    call $close)
  (func $writev (type $t0) (param $p0 i32) (param $p1 i32) (param $p2 i32) (result i32)
    (local $l3 i32) (local $l4 i32)
    global.get $g0
    i32.const 16
    i32.sub
    local.tee $l3
    global.set $g0
    i32.const -1
    local.set $l4
    block $B0
      block $B1
        local.get $p2
        i32.const -1
        i32.gt_s
        br_if $B1
        i32.const 0
        i32.const 28
        i32.store offset=1168
        br $B0
      end
      block $B2
        local.get $p0
        local.get $p1
        local.get $p2
        local.get $l3
        i32.const 12
        i32.add
        call $__wasi_fd_write
        local.tee $p2
        i32.eqz
        br_if $B2
        i32.const 0
        local.get $p2
        i32.store offset=1168
        i32.const -1
        local.set $l4
        br $B0
      end
      local.get $l3
      i32.load offset=12
      local.set $l4
    end
    local.get $l3
    i32.const 16
    i32.add
    global.set $g0
    local.get $l4)
  (func $__stdio_write (type $t0) (param $p0 i32) (param $p1 i32) (param $p2 i32) (result i32)
    (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32) (local $l8 i32) (local $l9 i32)
    global.get $g0
    i32.const 16
    i32.sub
    local.tee $l3
    global.set $g0
    local.get $l3
    local.get $p2
    i32.store offset=12
    local.get $l3
    local.get $p1
    i32.store offset=8
    local.get $l3
    local.get $p0
    i32.load offset=24
    local.tee $p1
    i32.store
    local.get $l3
    local.get $p0
    i32.load offset=20
    local.get $p1
    i32.sub
    local.tee $p1
    i32.store offset=4
    i32.const 2
    local.set $l4
    block $B0
      block $B1
        local.get $p1
        local.get $p2
        i32.add
        local.tee $l5
        local.get $p0
        i32.load offset=56
        local.get $l3
        i32.const 2
        call $writev
        local.tee $l6
        i32.eq
        br_if $B1
        local.get $l3
        local.set $p1
        loop $L2
          block $B3
            local.get $l6
            i32.const -1
            i32.gt_s
            br_if $B3
            i32.const 0
            local.set $l6
            local.get $p0
            i32.const 0
            i32.store offset=24
            local.get $p0
            i64.const 0
            i64.store offset=16
            local.get $p0
            local.get $p0
            i32.load
            i32.const 32
            i32.or
            i32.store
            local.get $l4
            i32.const 2
            i32.eq
            br_if $B0
            local.get $p2
            local.get $p1
            i32.load offset=4
            i32.sub
            local.set $l6
            br $B0
          end
          local.get $p1
          local.get $l6
          local.get $p1
          i32.load offset=4
          local.tee $l7
          i32.gt_u
          local.tee $l8
          i32.const 3
          i32.shl
          i32.add
          local.tee $l9
          local.get $l9
          i32.load
          local.get $l6
          local.get $l7
          i32.const 0
          local.get $l8
          select
          i32.sub
          local.tee $l7
          i32.add
          i32.store
          local.get $p1
          i32.const 12
          i32.const 4
          local.get $l8
          select
          i32.add
          local.tee $l9
          local.get $l9
          i32.load
          local.get $l7
          i32.sub
          i32.store
          local.get $l5
          local.get $l6
          i32.sub
          local.tee $l5
          local.get $p0
          i32.load offset=56
          local.get $p1
          i32.const 8
          i32.add
          local.get $p1
          local.get $l8
          select
          local.tee $p1
          local.get $l4
          local.get $l8
          i32.sub
          local.tee $l4
          call $writev
          local.tee $l6
          i32.ne
          br_if $L2
        end
      end
      local.get $p0
      local.get $p0
      i32.load offset=40
      local.tee $p1
      i32.store offset=24
      local.get $p0
      local.get $p1
      i32.store offset=20
      local.get $p0
      local.get $p1
      local.get $p0
      i32.load offset=44
      i32.add
      i32.store offset=16
      local.get $p2
      local.set $l6
    end
    local.get $l3
    i32.const 16
    i32.add
    global.set $g0
    local.get $l6)
  (func $__isatty (type $t4) (param $p0 i32) (result i32)
    (local $l1 i32) (local $l2 i32)
    global.get $g0
    i32.const 32
    i32.sub
    local.tee $l1
    global.set $g0
    block $B0
      block $B1
        local.get $p0
        local.get $l1
        i32.const 8
        i32.add
        call $__wasi_fd_fdstat_get
        local.tee $p0
        br_if $B1
        i32.const 59
        local.set $p0
        local.get $l1
        i32.load8_u offset=8
        i32.const 2
        i32.ne
        br_if $B1
        local.get $l1
        i32.load8_u offset=16
        i32.const 36
        i32.and
        br_if $B1
        i32.const 1
        local.set $l2
        br $B0
      end
      i32.const 0
      local.set $l2
      i32.const 0
      local.get $p0
      i32.store offset=1168
    end
    local.get $l1
    i32.const 32
    i32.add
    global.set $g0
    local.get $l2)
  (func $__stdout_write (type $t0) (param $p0 i32) (param $p1 i32) (param $p2 i32) (result i32)
    local.get $p0
    i32.const 4
    i32.store offset=32
    block $B0
      local.get $p0
      i32.load8_u
      i32.const 64
      i32.and
      br_if $B0
      local.get $p0
      i32.load offset=56
      call $__isatty
      br_if $B0
      local.get $p0
      i32.const -1
      i32.store offset=64
    end
    local.get $p0
    local.get $p1
    local.get $p2
    call $__stdio_write)
  (func $memcpy (type $t0) (param $p0 i32) (param $p1 i32) (param $p2 i32) (result i32)
    (local $l3 i32) (local $l4 i32) (local $l5 i32) (local $l6 i32) (local $l7 i32) (local $l8 i32)
    block $B0
      block $B1
        local.get $p2
        i32.eqz
        br_if $B1
        local.get $p1
        i32.const 3
        i32.and
        i32.eqz
        br_if $B1
        local.get $p0
        local.set $l3
        loop $L2
          local.get $l3
          local.get $p1
          i32.load8_u
          i32.store8
          local.get $p2
          i32.const -1
          i32.add
          local.set $l4
          local.get $l3
          i32.const 1
          i32.add
          local.set $l3
          local.get $p1
          i32.const 1
          i32.add
          local.set $p1
          local.get $p2
          i32.const 1
          i32.eq
          br_if $B0
          local.get $l4
          local.set $p2
          local.get $p1
          i32.const 3
          i32.and
          br_if $L2
          br $B0
        end
      end
      local.get $p2
      local.set $l4
      local.get $p0
      local.set $l3
    end
    block $B3
      block $B4
        local.get $l3
        i32.const 3
        i32.and
        local.tee $p2
        br_if $B4
        block $B5
          local.get $l4
          i32.const 16
          i32.lt_u
          br_if $B5
          loop $L6
            local.get $l3
            local.get $p1
            i32.load
            i32.store
            local.get $l3
            i32.const 4
            i32.add
            local.get $p1
            i32.const 4
            i32.add
            i32.load
            i32.store
            local.get $l3
            i32.const 8
            i32.add
            local.get $p1
            i32.const 8
            i32.add
            i32.load
            i32.store
            local.get $l3
            i32.const 12
            i32.add
            local.get $p1
            i32.const 12
            i32.add
            i32.load
            i32.store
            local.get $l3
            i32.const 16
            i32.add
            local.set $l3
            local.get $p1
            i32.const 16
            i32.add
            local.set $p1
            local.get $l4
            i32.const -16
            i32.add
            local.tee $l4
            i32.const 15
            i32.gt_u
            br_if $L6
          end
        end
        block $B7
          local.get $l4
          i32.const 8
          i32.and
          i32.eqz
          br_if $B7
          local.get $l3
          local.get $p1
          i64.load align=4
          i64.store align=4
          local.get $p1
          i32.const 8
          i32.add
          local.set $p1
          local.get $l3
          i32.const 8
          i32.add
          local.set $l3
        end
        block $B8
          local.get $l4
          i32.const 4
          i32.and
          i32.eqz
          br_if $B8
          local.get $l3
          local.get $p1
          i32.load
          i32.store
          local.get $p1
          i32.const 4
          i32.add
          local.set $p1
          local.get $l3
          i32.const 4
          i32.add
          local.set $l3
        end
        block $B9
          local.get $l4
          i32.const 2
          i32.and
          i32.eqz
          br_if $B9
          local.get $l3
          local.get $p1
          i32.load8_u
          i32.store8
          local.get $l3
          local.get $p1
          i32.load8_u offset=1
          i32.store8 offset=1
          local.get $l3
          i32.const 2
          i32.add
          local.set $l3
          local.get $p1
          i32.const 2
          i32.add
          local.set $p1
        end
        local.get $l4
        i32.const 1
        i32.and
        i32.eqz
        br_if $B3
        local.get $l3
        local.get $p1
        i32.load8_u
        i32.store8
        local.get $p0
        return
      end
      block $B10
        local.get $l4
        i32.const 32
        i32.lt_u
        br_if $B10
        block $B11
          block $B12
            block $B13
              local.get $p2
              i32.const -1
              i32.add
              br_table $B13 $B12 $B11 $B10
            end
            local.get $l3
            local.get $p1
            i32.load8_u offset=1
            i32.store8 offset=1
            local.get $l3
            local.get $p1
            i32.load
            local.tee $l5
            i32.store8
            local.get $l3
            local.get $p1
            i32.load8_u offset=2
            i32.store8 offset=2
            local.get $l4
            i32.const -3
            i32.add
            local.set $l4
            local.get $l3
            i32.const 3
            i32.add
            local.set $l6
            i32.const 0
            local.set $p2
            loop $L14
              local.get $l6
              local.get $p2
              i32.add
              local.tee $l3
              local.get $p1
              local.get $p2
              i32.add
              local.tee $l7
              i32.const 4
              i32.add
              i32.load
              local.tee $l8
              i32.const 8
              i32.shl
              local.get $l5
              i32.const 24
              i32.shr_u
              i32.or
              i32.store
              local.get $l3
              i32.const 4
              i32.add
              local.get $l7
              i32.const 8
              i32.add
              i32.load
              local.tee $l5
              i32.const 8
              i32.shl
              local.get $l8
              i32.const 24
              i32.shr_u
              i32.or
              i32.store
              local.get $l3
              i32.const 8
              i32.add
              local.get $l7
              i32.const 12
              i32.add
              i32.load
              local.tee $l8
              i32.const 8
              i32.shl
              local.get $l5
              i32.const 24
              i32.shr_u
              i32.or
              i32.store
              local.get $l3
              i32.const 12
              i32.add
              local.get $l7
              i32.const 16
              i32.add
              i32.load
              local.tee $l5
              i32.const 8
              i32.shl
              local.get $l8
              i32.const 24
              i32.shr_u
              i32.or
              i32.store
              local.get $p2
              i32.const 16
              i32.add
              local.set $p2
              local.get $l4
              i32.const -16
              i32.add
              local.tee $l4
              i32.const 16
              i32.gt_u
              br_if $L14
            end
            local.get $l6
            local.get $p2
            i32.add
            local.set $l3
            local.get $p1
            local.get $p2
            i32.add
            i32.const 3
            i32.add
            local.set $p1
            br $B10
          end
          local.get $l3
          local.get $p1
          i32.load
          local.tee $l5
          i32.store8
          local.get $l3
          local.get $p1
          i32.load8_u offset=1
          i32.store8 offset=1
          local.get $l4
          i32.const -2
          i32.add
          local.set $l4
          local.get $l3
          i32.const 2
          i32.add
          local.set $l6
          i32.const 0
          local.set $p2
          loop $L15
            local.get $l6
            local.get $p2
            i32.add
            local.tee $l3
            local.get $p1
            local.get $p2
            i32.add
            local.tee $l7
            i32.const 4
            i32.add
            i32.load
            local.tee $l8
            i32.const 16
            i32.shl
            local.get $l5
            i32.const 16
            i32.shr_u
            i32.or
            i32.store
            local.get $l3
            i32.const 4
            i32.add
            local.get $l7
            i32.const 8
            i32.add
            i32.load
            local.tee $l5
            i32.const 16
            i32.shl
            local.get $l8
            i32.const 16
            i32.shr_u
            i32.or
            i32.store
            local.get $l3
            i32.const 8
            i32.add
            local.get $l7
            i32.const 12
            i32.add
            i32.load
            local.tee $l8
            i32.const 16
            i32.shl
            local.get $l5
            i32.const 16
            i32.shr_u
            i32.or
            i32.store
            local.get $l3
            i32.const 12
            i32.add
            local.get $l7
            i32.const 16
            i32.add
            i32.load
            local.tee $l5
            i32.const 16
            i32.shl
            local.get $l8
            i32.const 16
            i32.shr_u
            i32.or
            i32.store
            local.get $p2
            i32.const 16
            i32.add
            local.set $p2
            local.get $l4
            i32.const -16
            i32.add
            local.tee $l4
            i32.const 17
            i32.gt_u
            br_if $L15
          end
          local.get $l6
          local.get $p2
          i32.add
          local.set $l3
          local.get $p1
          local.get $p2
          i32.add
          i32.const 2
          i32.add
          local.set $p1
          br $B10
        end
        local.get $l3
        local.get $p1
        i32.load
        local.tee $l5
        i32.store8
        local.get $l4
        i32.const -1
        i32.add
        local.set $l4
        local.get $l3
        i32.const 1
        i32.add
        local.set $l6
        i32.const 0
        local.set $p2
        loop $L16
          local.get $l6
          local.get $p2
          i32.add
          local.tee $l3
          local.get $p1
          local.get $p2
          i32.add
          local.tee $l7
          i32.const 4
          i32.add
          i32.load
          local.tee $l8
          i32.const 24
          i32.shl
          local.get $l5
          i32.const 8
          i32.shr_u
          i32.or
          i32.store
          local.get $l3
          i32.const 4
          i32.add
          local.get $l7
          i32.const 8
          i32.add
          i32.load
          local.tee $l5
          i32.const 24
          i32.shl
          local.get $l8
          i32.const 8
          i32.shr_u
          i32.or
          i32.store
          local.get $l3
          i32.const 8
          i32.add
          local.get $l7
          i32.const 12
          i32.add
          i32.load
          local.tee $l8
          i32.const 24
          i32.shl
          local.get $l5
          i32.const 8
          i32.shr_u
          i32.or
          i32.store
          local.get $l3
          i32.const 12
          i32.add
          local.get $l7
          i32.const 16
          i32.add
          i32.load
          local.tee $l5
          i32.const 24
          i32.shl
          local.get $l8
          i32.const 8
          i32.shr_u
          i32.or
          i32.store
          local.get $p2
          i32.const 16
          i32.add
          local.set $p2
          local.get $l4
          i32.const -16
          i32.add
          local.tee $l4
          i32.const 18
          i32.gt_u
          br_if $L16
        end
        local.get $l6
        local.get $p2
        i32.add
        local.set $l3
        local.get $p1
        local.get $p2
        i32.add
        i32.const 1
        i32.add
        local.set $p1
      end
      block $B17
        local.get $l4
        i32.const 16
        i32.and
        i32.eqz
        br_if $B17
        local.get $l3
        local.get $p1
        i32.load16_u align=1
        i32.store16 align=1
        local.get $l3
        local.get $p1
        i32.load8_u offset=2
        i32.store8 offset=2
        local.get $l3
        local.get $p1
        i32.load8_u offset=3
        i32.store8 offset=3
        local.get $l3
        local.get $p1
        i32.load8_u offset=4
        i32.store8 offset=4
        local.get $l3
        local.get $p1
        i32.load8_u offset=5
        i32.store8 offset=5
        local.get $l3
        local.get $p1
        i32.load8_u offset=6
        i32.store8 offset=6
        local.get $l3
        local.get $p1
        i32.load8_u offset=7
        i32.store8 offset=7
        local.get $l3
        local.get $p1
        i32.load8_u offset=8
        i32.store8 offset=8
        local.get $l3
        local.get $p1
        i32.load8_u offset=9
        i32.store8 offset=9
        local.get $l3
        local.get $p1
        i32.load8_u offset=10
        i32.store8 offset=10
        local.get $l3
        local.get $p1
        i32.load8_u offset=11
        i32.store8 offset=11
        local.get $l3
        local.get $p1
        i32.load8_u offset=12
        i32.store8 offset=12
        local.get $l3
        local.get $p1
        i32.load8_u offset=13
        i32.store8 offset=13
        local.get $l3
        local.get $p1
        i32.load8_u offset=14
        i32.store8 offset=14
        local.get $l3
        local.get $p1
        i32.load8_u offset=15
        i32.store8 offset=15
        local.get $l3
        i32.const 16
        i32.add
        local.set $l3
        local.get $p1
        i32.const 16
        i32.add
        local.set $p1
      end
      block $B18
        local.get $l4
        i32.const 8
        i32.and
        i32.eqz
        br_if $B18
        local.get $l3
        local.get $p1
        i32.load8_u
        i32.store8
        local.get $l3
        local.get $p1
        i32.load8_u offset=1
        i32.store8 offset=1
        local.get $l3
        local.get $p1
        i32.load8_u offset=2
        i32.store8 offset=2
        local.get $l3
        local.get $p1
        i32.load8_u offset=3
        i32.store8 offset=3
        local.get $l3
        local.get $p1
        i32.load8_u offset=4
        i32.store8 offset=4
        local.get $l3
        local.get $p1
        i32.load8_u offset=5
        i32.store8 offset=5
        local.get $l3
        local.get $p1
        i32.load8_u offset=6
        i32.store8 offset=6
        local.get $l3
        local.get $p1
        i32.load8_u offset=7
        i32.store8 offset=7
        local.get $l3
        i32.const 8
        i32.add
        local.set $l3
        local.get $p1
        i32.const 8
        i32.add
        local.set $p1
      end
      block $B19
        local.get $l4
        i32.const 4
        i32.and
        i32.eqz
        br_if $B19
        local.get $l3
        local.get $p1
        i32.load8_u
        i32.store8
        local.get $l3
        local.get $p1
        i32.load8_u offset=1
        i32.store8 offset=1
        local.get $l3
        local.get $p1
        i32.load8_u offset=2
        i32.store8 offset=2
        local.get $l3
        local.get $p1
        i32.load8_u offset=3
        i32.store8 offset=3
        local.get $l3
        i32.const 4
        i32.add
        local.set $l3
        local.get $p1
        i32.const 4
        i32.add
        local.set $p1
      end
      block $B20
        local.get $l4
        i32.const 2
        i32.and
        i32.eqz
        br_if $B20
        local.get $l3
        local.get $p1
        i32.load8_u
        i32.store8
        local.get $l3
        local.get $p1
        i32.load8_u offset=1
        i32.store8 offset=1
        local.get $l3
        i32.const 2
        i32.add
        local.set $l3
        local.get $p1
        i32.const 2
        i32.add
        local.set $p1
      end
      local.get $l4
      i32.const 1
      i32.and
      i32.eqz
      br_if $B3
      local.get $l3
      local.get $p1
      i32.load8_u
      i32.store8
    end
    local.get $p0)
  (func $strlen (type $t4) (param $p0 i32) (result i32)
    (local $l1 i32) (local $l2 i32) (local $l3 i32)
    local.get $p0
    local.set $l1
    block $B0
      block $B1
        block $B2
          local.get $p0
          i32.const 3
          i32.and
          i32.eqz
          br_if $B2
          block $B3
            local.get $p0
            i32.load8_u
            br_if $B3
            local.get $p0
            local.get $p0
            i32.sub
            return
          end
          local.get $p0
          i32.const 1
          i32.add
          local.set $l1
          loop $L4
            local.get $l1
            i32.const 3
            i32.and
            i32.eqz
            br_if $B2
            local.get $l1
            i32.load8_u
            local.set $l2
            local.get $l1
            i32.const 1
            i32.add
            local.tee $l3
            local.set $l1
            local.get $l2
            i32.eqz
            br_if $B1
            br $L4
          end
        end
        local.get $l1
        i32.const -4
        i32.add
        local.set $l1
        loop $L5
          local.get $l1
          i32.const 4
          i32.add
          local.tee $l1
          i32.load
          local.tee $l2
          i32.const -1
          i32.xor
          local.get $l2
          i32.const -16843009
          i32.add
          i32.and
          i32.const -2139062144
          i32.and
          i32.eqz
          br_if $L5
        end
        block $B6
          local.get $l2
          i32.const 255
          i32.and
          br_if $B6
          local.get $l1
          local.get $p0
          i32.sub
          return
        end
        loop $L7
          local.get $l1
          i32.load8_u offset=1
          local.set $l2
          local.get $l1
          i32.const 1
          i32.add
          local.tee $l3
          local.set $l1
          local.get $l2
          br_if $L7
          br $B0
        end
      end
      local.get $l3
      i32.const -1
      i32.add
      local.set $l3
    end
    local.get $l3
    local.get $p0
    i32.sub)
  (table $T0 5 5 funcref)
  (memory $memory 2)
  (global $g0 (mut i32) (i32.const 67760))
  (export "memory" (memory 0))
  (export "_start" (func $_start))
  (elem $e0 (i32.const 1) $__stdio_close $__stdout_write $__stdio_seek $__stdio_write)
  (data $d0 (i32.const 1024) "hehehehehe\00")
  (data $d1 (i32.const 1040) "\05\00\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\03\00\00\00\a8\04\00\00\00\04\00\00\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\0a\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\10\04\00\00"))
