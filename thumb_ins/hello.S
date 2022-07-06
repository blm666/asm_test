.data

/* Data segment: define our message string and calculate its length. */
msg:
    .ascii      "Hello, thumb!\n"
len = . - msg

.text

.thumb
_my_thumb_entry:
     /* syscall write(int fd, const void *buf, size_t count) */
    mov     %r0, $1     /* fd := STDOUT_FILENO */
    ldr     %r1, =msg   /* buf := msg */
    ldr     %r2, =len   /* count := len */
    mov     %r7, $4     /* write is syscall #4 */
    swi     $0          /* invoke syscall */

    /* syscall exit(int status) */
    mov     %r0, $0     /* status := 0 */
    mov     %r7, $1     /* exit is syscall #1 */
    swi     $0          /* invoke syscall */

/* Our application's entry point. */
.globl _start
_start:
//入口点必须为arm指令
.arm
   blx _my_thumb_entry //带切换模式的跳转