; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -slp-vectorizer -S -mcpu=cascadelake -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s

define void @foo() {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CONV:%.*]] = uitofp i16 undef to float
; CHECK-NEXT:    [[SUB:%.*]] = fsub float 6.553500e+04, undef
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <4 x float> poison, float [[SUB]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x float> [[TMP0]], float [[CONV]], i32 1
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP2:%.*]] = phi <4 x float> [ [[TMP1]], [[BB1]] ], [ [[TMP18:%.*]], [[BB3:%.*]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = load double, double* undef, align 8
; CHECK-NEXT:    br i1 undef, label [[BB3]], label [[BB4:%.*]]
; CHECK:       bb4:
; CHECK-NEXT:    [[CONV2:%.*]] = uitofp i16 undef to double
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <2 x double> <double undef, double poison>, double [[TMP3]], i32 1
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <2 x double> <double undef, double poison>, double [[CONV2]], i32 1
; CHECK-NEXT:    [[TMP6:%.*]] = fsub <2 x double> [[TMP4]], [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = fadd <2 x double> [[TMP4]], [[TMP5]]
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <2 x double> [[TMP6]], <2 x double> [[TMP7]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    [[TMP9:%.*]] = fpext <4 x float> [[TMP2]] to <4 x double>
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <2 x double> [[TMP8]], i32 0
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <4 x double> poison, double [[TMP10]], i32 0
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <2 x double> [[TMP8]], i32 1
; CHECK-NEXT:    [[TMP13:%.*]] = insertelement <4 x double> [[TMP11]], double [[TMP12]], i32 1
; CHECK-NEXT:    [[TMP14:%.*]] = fcmp ogt <4 x double> [[TMP13]], [[TMP9]]
; CHECK-NEXT:    [[TMP15:%.*]] = shufflevector <2 x double> [[TMP8]], <2 x double> poison, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
; CHECK-NEXT:    [[TMP16:%.*]] = fptrunc <4 x double> [[TMP15]] to <4 x float>
; CHECK-NEXT:    [[TMP17:%.*]] = select <4 x i1> [[TMP14]], <4 x float> [[TMP2]], <4 x float> [[TMP16]]
; CHECK-NEXT:    br label [[BB3]]
; CHECK:       bb3:
; CHECK-NEXT:    [[TMP18]] = phi <4 x float> [ [[TMP17]], [[BB4]] ], [ [[TMP2]], [[BB2]] ]
; CHECK-NEXT:    br label [[BB2]]
;
entry:
  %conv = uitofp i16 undef to float
  %sub = fsub float 6.553500e+04, undef
  br label %bb1

bb1:
  br label %bb2

bb2:
  %0 = phi float [ %sub, %bb1 ], [ %9, %bb3 ]
  %1 = phi float [ %conv, %bb1 ], [ %10, %bb3 ]
  %2 = phi float [ undef, %bb1 ], [ %11, %bb3 ]
  %3 = phi float [ undef, %bb1 ], [ %12, %bb3 ]
  %4 = load double, double* undef, align 8
  br i1 undef, label %bb3, label %bb4

bb4:
  %ext = fpext float %3 to double
  %cmp1 = fcmp ogt double undef, %ext
  %5 = fptrunc double undef to float
  %sel1 = select i1 %cmp1, float %3, float %5
  %ext2 = fpext float %2 to double
  %cmp2 = fcmp ogt double undef, %ext2
  %6 = fptrunc double undef to float
  %sel2 = select i1 %cmp2, float %2, float %6
  %ext3 = fpext float %1 to double
  %conv2 = uitofp i16 undef to double
  %add1 = fadd double %4, %conv2
  %cmp3 = fcmp ogt double %add1, %ext3
  %7 = fptrunc double %add1 to float
  %sel3 = select i1 %cmp3, float %1, float %7
  %ext4 = fpext float %0 to double
  %sub1 = fsub double undef, undef
  %cmp4 = fcmp ogt double %sub1, %ext4
  %8 = fptrunc double %sub1 to float
  %sel4 = select i1 %cmp4, float %0, float %8
  br label %bb3

bb3:
  %9 = phi float [ %sel4, %bb4 ], [ %0, %bb2 ]
  %10 = phi float [ %sel3, %bb4 ], [ %1, %bb2 ]
  %11 = phi float [ %sel2, %bb4 ], [ %2, %bb2 ]
  %12 = phi float [ %sel1, %bb4 ], [ %3, %bb2 ]
  br label %bb2
}
