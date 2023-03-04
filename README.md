# btg-ofx
A straightforward OFX generation tool for BTG bank's credit card bill.

It transforms a PDF bill into a .ofx file.

## Limitations

1. It only works for BTG bank.
2. It only supports BRL currency.
3. It only supports the Portuguese month abbreviation.
4. The resulting OFX does not represents installments as defined by the protocol.

## Usage

```sh
$ ./ofx_generator ./bill.pdf
```
