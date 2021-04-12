; ModuleID = 'calc.c'
source_filename = "calc.c"
target datalayout = "e-m:e-p:32:32-i64:64-n32:64-S128"
target triple = "wasm32-unknown-wasi"

@__const.testSort.nums = private unnamed_addr constant [5 x i32] [i32 2, i32 4, i32 3, i32 1, i32 2], align 16

; Function Attrs: noinline nounwind optnone
define hidden i32 @intcmp(i8* %0, i8* %1) #0 {
  %3 = alloca i8*, align 4
  %4 = alloca i8*, align 4
  %5 = alloca i32*, align 4
  %6 = alloca i32*, align 4
  store i8* %0, i8** %3, align 4
  store i8* %1, i8** %4, align 4
  %7 = load i8*, i8** %3, align 4
  %8 = bitcast i8* %7 to i32*
  store i32* %8, i32** %5, align 4
  %9 = load i8*, i8** %4, align 4
  %10 = bitcast i8* %9 to i32*
  store i32* %10, i32** %6, align 4
  %11 = load i32*, i32** %5, align 4
  %12 = load i32, i32* %11, align 4
  %13 = load i32*, i32** %6, align 4
  %14 = load i32, i32* %13, align 4
  %15 = icmp slt i32 %12, %14
  br i1 %15, label %16, label %17

16:                                               ; preds = %2
  br label %24

17:                                               ; preds = %2
  %18 = load i32*, i32** %5, align 4
  %19 = load i32, i32* %18, align 4
  %20 = load i32*, i32** %6, align 4
  %21 = load i32, i32* %20, align 4
  %22 = icmp sgt i32 %19, %21
  %23 = zext i1 %22 to i32
  br label %24

24:                                               ; preds = %17, %16
  %25 = phi i32 [ -1, %16 ], [ %23, %17 ]
  ret i32 %25
}

; Function Attrs: noinline nounwind optnone
define hidden i32 @testSort(i32* %0, i32 %1) #0 {
  %3 = alloca i32*, align 4
  %4 = alloca i32, align 4
  %5 = alloca [5 x i32], align 16
  store i32* %0, i32** %3, align 4
  store i32 %1, i32* %4, align 4
  %6 = bitcast [5 x i32]* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* align 16 %6, i8* align 16 bitcast ([5 x i32]* @__const.testSort.nums to i8*), i32 20, i1 false)
  %7 = getelementptr inbounds [5 x i32], [5 x i32]* %5, i32 0, i32 0
  %8 = bitcast i32* %7 to i8*
  call void @qsort(i8* %8, i32 5, i32 4, i32 (i8*, i8*)* @intcmp)
  ret i32 0
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i32, i1 immarg) #1

declare void @qsort(i8*, i32, i32, i32 (i8*, i8*)*) #2

; Function Attrs: noinline nounwind optnone
define hidden double @factorial(double %0) #0 {
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  store double %0, double* %3, align 8
  %4 = load double, double* %3, align 8
  %5 = fcmp ole double %4, 1.000000e+00
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  store double 1.000000e+00, double* %2, align 8
  br label %13

7:                                                ; preds = %1
  %8 = load double, double* %3, align 8
  %9 = load double, double* %3, align 8
  %10 = fsub double %9, 1.000000e+00
  %11 = call double @factorial(double %10)
  %12 = fmul double %8, %11
  store double %12, double* %2, align 8
  br label %13

13:                                               ; preds = %7, %6
  %14 = load double, double* %2, align 8
  ret double %14
}

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}
