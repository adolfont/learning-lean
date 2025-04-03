def bufsize : USize := 20 * 1024

partial def dump (stream : IO.FS.Stream) : IO Unit := do
  let buf ← stream.read bufsize
  if buf.isEmpty then
    pure ()
  else
    (← IO.getStdout).write buf
    dump stream


def fileStream (filename : System.FilePath) : IO (Option IO.FS.Stream) := do
  if not (← filename.pathExists) then
    (← IO.getStderr).putStrLn s!"File not found: {filename}"
    pure none
  else
    let handle ← IO.FS.Handle.mk filename IO.FS.Mode.read
    pure (some (IO.FS.Stream.ofHandle handle))



def process (exitCode : UInt32) (args : List String) : IO UInt32 := do
  match args with
  | [] => pure exitCode
  | "-" :: args =>
    let stdin ← IO.getStdin
    dump stdin
    process exitCode args
  | filename :: args =>
    let stream ← fileStream ⟨filename⟩
    match stream with
    | none =>
      process 1 args
    | some stream =>
      dump stream
      process exitCode args

def printHelp : IO UInt32 := do
  let stdout ← IO.getStdout
  stdout.putStrLn "Usage: feline [OPTION]... [FILE]..."
  stdout.putStrLn "Concatenate FILE(s) to standard output."
  stdout.putStrLn ""
  stdout.putStrLn "With no FILE, or when FILE is -, read standard input."
  pure 0

def main (args : List String) : IO UInt32 :=
  match args with
  | [] => process 0 ["-"]
  | ["--help"] => printHelp
  | _ =>  process 0 args
