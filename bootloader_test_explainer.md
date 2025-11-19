Here is a clean, simple explanation of **every line** of your bootloader code.

---

# ✅ **What this program is**

This is a **Stage-1 bootloader** written in **16-bit Assembly**, meant to:

✔ Run immediately after BIOS loads the first 512 bytes from disk
✔ Print `"Hello, world!"` directly to the screen using BIOS interrupts
✔ Loop forever
✔ End with the required **0xAA55 boot signature**

This is the simplest possible real bootloader.

---

# 🔍 **Line-by-Line Explanation**

---

## **`bits 16`**

* Tells the assembler (NASM) that the CPU will run this code in **16-bit real mode**.
* BIOS always starts the bootloader in **16-bit mode**, so this is required.

---

## **`org 0x7c00`**

* BIOS loads the first sector (512 bytes) to memory address **0x7C00**.
* `org` tells NASM to treat the code as if it starts from address **0x7C00**.
* Important for correct addressing.

---

## **`mov si, 0`**

* Set string index register `SI = 0`.
* `SI` will be used to walk through each character of `"Hello, world!"`.

---

# 🔁 **Print Loop**

## **`print:`**

Label marking the start of the loop.

---

## **`mov ah, 0x0e`**

* BIOS teletype output function (`int 0x10, AH=0x0E`)
* Prints a single character to the screen.

---

## **`mov al, [hello + si]`**

* Load **one character** from memory:

  * `hello` = address of string
  * `si` = index
* Example:

  * first: AL = 'H'
  * second: AL = 'e'
  * etc.

---

## **`int 0x10`**

* BIOS interrupt to print the character stored in AL.

---

## **`add si, 1`**

* Move to the next character in the string.

---

## **`cmp byte [hello + si], 0`**

* Compare next character to **0**.
* The string ends with a **null terminator (0x00)**.

---

## **`jne print`**

* If next character is **not zero**, jump back to `print`.
* If zero → loop ends.

---

# 🔁 **`jmp $`**

* `$` means the current address.
* So this is an **infinite loop**.
* Prevents the CPU from running into garbage memory.

---

# 📌 **String storage**

## **`hello:`**

Label to mark address of string.

## **`db "Hello, world!", 0`**

* `db` = define bytes (raw data)
* Text stored exactly as ASCII:

  * `H e l l o , …`
* Final `0` = null terminator.

---

# 📦 **Padding the boot sector**

## **`times 510 - ($ - $$) db 0`**

This ensures the bootloader is **exactly 512 bytes**:

* `$` = current address
* `$$` = start of file
* `($ - $$)` = current size
* `510 - (...)` = fill remaining bytes with zeros

Why 510?

Because last **2 bytes** must be the boot signature.

---

# 🛂 **Boot signature**

## **`dw 0xAA55`**

* Required by BIOS.
* Must be at offset **510–511**.

If missing → BIOS will refuse to boot your code.

---

# ▶ How to assemble and run

### **Compile**

```
nasm -f bin boot.asm -o boot.bin
```

### **Run**

```
qemu-system-i386 -drive format=raw,file=boot.bin
```

---

# ⚡ Want deeper explanation?

I can also show you:

✔ Memory map of real mode
✔ How BIOS loads your bootloader
✔ How to switch to protected mode
✔ How to switch to long mode (64-bit)
✔ How to write Stage-2 in C
✔ How GRUB works

Just tell me what level you want!
