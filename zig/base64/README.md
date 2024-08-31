# Base64 Enconder & Decoder Project

Base64 is an encoding system which translates binary data to text.

The web uses `base64` to deliver binary data to systems that can only read
text data.

`base64` encoding is largelly used in email systems to include binary data
into SMTP messages.

## Base64 Algorithm

### The `base64` scale

The `base64` encoding system is based on a scale that goes from `0` to `64`.

Each index in this scale is represented by a character, it is a scale of
`64` characters.

Indicies `0` to `25` represent ASCII uppercase letters `A` to `Z`.

Indicies `26` to `51` represent ASCII lowercase letters `a` to `z`.

Indicies `52` to `61` represent the digits `0` to `9`.

Index `62` represents `+`.

Index `63` represents `/`.

The character `=` is not part of the scale, used as a suffix to mark the end
of the character sequence or mark the end of meaningful characters in
the sequence.

### A `base64` Encoder

The `base64` encoder algorithm works on a window of `3` bytes. This is because
each byte has `8` bits, so `3` bytes forms a set of `8 x 3 = 24` bits. Since
`24` bits is divisible by `6`, it forms a set of `4` groups of `6` bits each.

### A `base64` Decoder

The `base64` decoder algorithm is essentially the inverse process of a `base64`
encoder. A `base64` decoder usually works on a window of `4` bytes because it
wants to convert the `4` bytes` back into the original sequence of `3` bytes,
that was converted into `4` groups of `6` bits by the `base64` encoder.

## Calculating the Size of the Output

One task is to calculate how much space the program needs to reserve for the
output, both of the encoder and decoder.

For the encoder, the logic is as follows, for each `3` bytes in the input,
`4` new bytes are created in the output. Take the number of bytes in the
input, divide it by `3`, use a ceiling function, multiply the result by `4`.
This produces the total number of bytes that will be produced by the encoder
in it's output.
