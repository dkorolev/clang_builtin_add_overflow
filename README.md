# The follow-up to [this LinkedIn post](https://www.linkedin.com/posts/dimakorolev_an-innocent-question-is-there-a-simple-way-activity-7131961959498833920-e8CQ).

Just `./run.sh` should do the trick.

## Results

For the record, we are comparing `native.cc`:

```
  while (true) {
    ++iteration;
    step = (step / 8) + step;
    value += step;
    if (value < step) {
      break;
    }
  }
```

To `clang_extension.cc`:

```
  while (true) {
    ++iteration;
    step = (step / 8) + step;
    if (__builtin_add_overflow(value, step, &value)) {
      break;
    }
  }
```

From this [Github Action Run](https://github.com/dkorolev/clang_builtin_add_overflow/actions/runs/6925792599):

* Results: All four { debug, release } * { ubuntu, macos } match.
* Ubuntu resulting assembly code: identical & clean (1).
* MacOS resulting assembly code: optimized away for `native.cc`, same identical & clean for `clang_extension.cc` (2).

### Footnote 1: Ubuntu `.s` code.

Identical for-loops:

```
.L4:
	movq	%rdx, %rcx
	addl	$1, %ebp
	shrq	$3, %rcx
	addq	%rcx, %rdx
	addq	%rdx, %rax
	jnc	.L4
```

### Footenot 2: MacOS `.s` code.

`native.cc`: The code appears to be optimized away.

`clang_extension.cc`: Appears _almost_ identical to the `Ubuntu` code above.

```
LBB0_1:
	addl	$1, %ebx
	movq	%rax, %rdx
	shrq	$3, %rdx
	addq	%rdx, %rax
	addq	%rax, %rcx
	jae	LBB0_1
```
