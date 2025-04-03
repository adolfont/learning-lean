--  Interlude: Propositions, Proofs, and Indexing

def woodlandCritters : List String :=
  ["hedgehog", "deer", "snail"]


def hedgehog := woodlandCritters[0]
def deer := woodlandCritters[1]
def snail := woodlandCritters[2]

#eval snail

-- def oops := woodlandCritters[3]

-- Propositions and Proofs

-- "Computer-aided theorem provers like Lean are designed
-- to allow mathematicians to write proofs while omitting
-- many details, and it is the software's responsibility
-- to fill in the missing explicit steps"


-- rfl is short for reflexivity

def onePlusOneIsTwo_v1 : 1 + 1 = 2 := rfl

-- def onePlusOneIsFifteen : 1 + 1 = 15 := rfl

def OnePlusOneIsTwo : Prop := 1 + 1 = 2

theorem onePlusOneIsTwo_v2 : OnePlusOneIsTwo := rfl


-- Tactics

-- "Proofs are normally written using tactics,
-- rather than by providing evidence directly.""

-- "Tactics are small programs that construct evidence
-- for a proposition."


theorem onePlusOneIsTwo : 1 + 1 = 2 := by
  simp


-- Connectives


-- It is in the book but returns an error
-- theorem addAndAppend_v1 : 1 + 1 = 2 ∧ (("Str".append "ing") = "String") := by
-- rfl

-- suggested by ChatGPT
theorem addAndAppend : 1 + 1 = 2 ∧ (("Str".append "ing") = "String") := by
  constructor
  · rfl  -- Proves `1 + 1 = 2`
  · rfl  -- Proves `("Str".append "ing") = "String"`


#eval "Str".append "ing"


theorem andImpliesOr : A ∧ B → A ∨ B :=
  fun andEvidence =>
    match andEvidence with
    | And.intro a _b => Or.inl a


theorem onePlusOneAndLessThan : 1 + 1 = 2 ∨ 3 < 5 := by simp
theorem notTwoEqualFive : ¬(1 + 1 = 5) := by simp
theorem trueIsTrue : True := True.intro
theorem trueOrFalse : True ∨ False := by simp
theorem falseImpliesTrue : False → True := by simp

-- Evidence as Arguments

-- error: " a function that returns the third entry in a list is not generally safe because lists might contain zero, one, or two entries:"
-- def third (xs : List α) : α := xs[2]


def third (xs : List α) (ok : xs.length > 2) : α := xs[2]


-- I had to use eval! and not eval

#eval! third woodlandCritters (by simp)


-- Indexing Without Evidence

def thirdOption (xs : List α) : Option α := xs[2]?

#eval thirdOption woodlandCritters

#eval thirdOption ["only", "two"]

#eval woodlandCritters[1]!


-- Messages You May Meet

-- def unsafeThird (xs : List α) : α := xs[2]!


-- #eval woodlandCritters [1]


-- Exercises


theorem add_five : 2 + 3 = 5 := rfl
theorem sub_seven : 15 - 8 = 7 := rfl
theorem append_hello : "Hello, ".append "world" = "Hello, world" := rfl

-- theorem fifteen_less_than_18 : 15<18 := rfl
-- rfl is for equality?


theorem add_five_simp : 2 + 3 = 5 := by simp
theorem sub_seven_simp : 15 - 8 = 7 := by simp
theorem append_hello_simp : "Hello, ".append "world" = "Hello, world" := by rfl
theorem five_lt_eighteen : 5 < 18 := by simp


def fifth (xs : List α) (ok : xs.length > 4) : α := xs[4]
