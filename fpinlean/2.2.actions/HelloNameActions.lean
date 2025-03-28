def twice (action : IO Unit) : IO Unit := do
  action
  action

def nTimes (action : IO Unit) : Nat → IO Unit
  | 0 => pure ()
  | n + 1 => do
    action
    nTimes action n


def main : IO Unit := do
  let stdin ← IO.getStdin
  let stdout ← IO.getStdout

  stdout.putStrLn "Como você gostaria de ser chamado(a)?"
  let input ← stdin.getLine
  let name := input.dropRightWhile Char.isWhitespace


  stdout.putStrLn s!"Two Times:"

  twice (stdout.putStrLn s!"Oi, {name}!")

  stdout.putStrLn s!"Five Times:"

  nTimes (stdout.putStrLn s!"Oi, {name}!") 5

-- lean --run HelloNameActions.lean
