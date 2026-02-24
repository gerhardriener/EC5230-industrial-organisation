---
name: create-exam
description: >
  Full exam creation workflow for EC5230 Industrial Organisation. Use this skill
  whenever the user wants to create, draft, or generate an exam paper, class test,
  deferred exam, or resit paper for EC5230. Also triggers on phrases like "write
  an exam", "draft a final exam", "create a class test", "make a deferred paper",
  or "I need an exam for [topic/lecture]". The skill conducts an interactive
  interview, generates the exam as a Quarto Markdown (.qmd) file, renders it to
  Word (.docx) using the cover-sheet merge script, creates a parallel solutions
  file, and produces a learning-outcome mapping table — all organised in a
  year-stamped subfolder of exams/.
---

# Exam Creation Workflow

This skill creates exam papers for EC5230 Industrial Organisation. It handles the
full pipeline: interview, content generation, file creation, ILO mapping, and
final Word output.

## Output layout

All outputs go into a year-stamped subfolder:

```
exams/<exam-type>/<academic-year>/
  <stem>.qmd                  # exam questions in Quarto Markdown
  <stem>-solutions.qmd        # solutions file (parallel structure)
  <stem>-final.docx           # merged cover sheet + exam body (Word)
  <stem>-solutions-final.docx # solutions as Word document
  ilo-mapping.md              # learning-outcome mapping table
```

Where:
- `<exam-type>` is one of: `final-exam`, `class-test`
- `<academic-year>` is in the format `2025-26` (start–end years)
- `<stem>` encodes the exam type and diet, e.g. `final-exam-main`, `final-exam-deferred`, `class-test`

---

## Step 1: Interview

Before writing anything, conduct a focused interview. Many parameters can be
inferred from context, but you need the following confirmed:

### Required information

1. **Exam type and diet** — one of:
   - `final-exam-main` (May sitting)
   - `final-exam-deferred` (deferred paper, same diet or extended May)
   - `final-exam-resit` (August resit)
   - `class-test` (in-semester test)

2. **Academic year** — default `2025-26` unless the user specifies otherwise.

3. **Topics / lectures to cover** — which lectures to draw questions from.
   The user may say "all lectures" or list specific ones (e.g. "lectures 1-5").

4. **Learning outcomes (ILOs)** — the module has four ILOs, defined in
   `resources/EC5230-module-description-2025-26.md`:
   - **ILO 1:** Understand how IO deepens the understanding of firm/agent behaviour
     in imperfectly competitive markets.
   - **ILO 2:** Select the right model(s) to analyse various issues in industrial
     economics.
   - **ILO 3:** Analyse economic behaviour through game theory.
   - **ILO 4:** Develop curiosity by identifying interesting papers and examples to
     extend knowledge of the subject.

   Use these verbatim in the ILO mapping table. You do not need to ask the user for
   the ILO list — it is already known. Note: ILO 4 is typically assessed through the
   policy report coursework, not the exam; include it only where a question
   genuinely invites students to draw on wider reading or policy implications.

5. **Exam structure** — confirm the default is appropriate:
   - **Section A** (short calculation/derivation questions, ~60% of total marks)
   - **Section B** (one larger integrative question, ~40% of total marks)
   - Total marks: typically 100 for the final exam, 20 for the class test.
   - If this does not match what the user wants, adjust.

6. **Number of questions** — for a 2-hour final exam, 4-5 questions is typical.
   Confirm with user if context is ambiguous.

7. **Any specific topics the exam must include or avoid** — e.g. "include a
   product differentiation question", "no repeated games".

### Interview style

Ask only what you genuinely cannot infer. If the user has already provided
information in their request, use it — don't ask again. Group remaining questions
together so the user answers in one go rather than in many rounds. Present
sensible defaults as options when possible.

---

## Step 2: Read existing context

Before writing questions:

1. Read `exams/_metadata.yml` to get the module code, title, duration, and
   standard instructions.
2. Check `exams/<exam-type>/` for any existing exams of the same type to
   understand question style, notation conventions, and mark allocation patterns.
3. If the user is creating a deferred or resit paper, read the main paper (if it
   exists) so you do not duplicate questions.

---

## Step 3: Write the exam (.qmd)

Create `exams/<exam-type>/<academic-year>/<stem>.qmd`.

### Front matter

The QMD front matter must be minimal — the cover sheet provides all title
information. Use exactly:

```yaml
---
title: " "
subtitle: " "
author: " "
---
```

### Content conventions

Follow the style established in `exams/class-test/class-test-lectures-1-5.qmd`:

- Start with `\newpage` after the front matter.
- Use `## Section A (N marks)` and `## Section B (N marks)` headers.
- Use `### Question N: [Short title] (N marks)` for each question.
- Write question stems in plain prose, then sub-parts as numbered lists.
- Use `$$...$$` for display math, `$...$` for inline math.
- Separate questions with `---`.
- Use `\newpage` before Section B and before the final question if needed.

### Content quality

Questions must be:
- **Solvable in the allotted time** — a 20-mark question in a 2-hour exam
  should take a well-prepared student 20-25 minutes.
- **Theory-first** — grounded in the canonical IO models from the lectures.
- **Self-contained** — all parameters and notation defined in the question.
- **Not ambiguous** — sub-part marks should be specified where the user's
  instructions call for it (use **[N]** inline after the sub-part if needed).
- **Consistent notation** with the lecture slides (e.g. $Q = q_1 + q_2$,
  inverse demand $P = A - Q$, etc.).

If you are covering a topic that appears in the lecture slides, align the model
setup with the canonical version taught in the slides (e.g. the Arrow replacement
effect uses specific parameter conventions — match them).

---

## Step 4: Write the solutions (.qmd)

Create `exams/<exam-type>/<academic-year>/<stem>-solutions.qmd`.

Front matter is the same as the exam, except add a subtitle indicating solutions:

```yaml
---
title: " "
subtitle: "Solutions"
author: " "
---
```

Write worked solutions for every sub-part:
- Show all algebra steps that a student would be expected to show.
- Clearly identify the final answer (bold or boxed where helpful).
- Add brief marking guidance notes in italics where useful, e.g.
  *[Award 1 mark for correct best-response derivation, 1 mark for correct
  equilibrium quantities.]*
- Solutions must be consistent with the exam questions — double-check numbers.

---

## Step 5: Write the ILO mapping table

Create `exams/<exam-type>/<academic-year>/ilo-mapping.md`.

Read `references/ilo-mapping-template.md` for the canonical table format.

The table maps each question (and sub-part where appropriate) to:
- The ILOs it assesses
- The marks available
- A brief note on the assessment method (calculation, derivation, interpretation,
  essay)

If the user has not yet provided ILO text, use `[ILO N - to be confirmed]` as
placeholder text and add a note at the top of the file:

> **Note:** ILO descriptions are placeholders. Replace with text from the module
> handbook before submitting to the School.

---

## Step 6: Render to Word

After writing all QMD files, render the exam and solutions to Word using the
cover-sheet merge script.

Run for the exam:
```bash
python scripts/build_exam.py exams/<exam-type>/<academic-year>/<stem>.qmd --cover in-person
```

Run for the solutions:
```bash
python scripts/build_exam.py exams/<exam-type>/<academic-year>/<stem>-solutions.qmd --cover in-person
```

The script will:
1. Render the QMD to a plain `.docx` via Quarto.
2. Populate the cover sheet with metadata from `exams/_metadata.yml`.
3. Merge cover + body into `<stem>-final.docx` in the same folder.

If the script fails, report the error clearly and suggest fixes (e.g. if Quarto
is not installed, or if the cover sheet file is missing).

---

## Step 7: Report to user

After all files are created and rendered, give the user a concise summary:

```
## Exam created

**Type:** [e.g. EC5230 Final Exam — Main paper, 2025-26]
**Folder:** exams/final-exam/2025-26/

### Files generated
- final-exam-main.qmd          (exam questions)
- final-exam-main-solutions.qmd (worked solutions)
- final-exam-main-final.docx   (Word output with cover sheet)
- final-exam-main-solutions-final.docx
- ilo-mapping.md               (learning-outcome mapping)

### Questions
| Section | Question | Topic | Marks |
|---------|----------|-------|-------|
| A       | Q1       | ...   | N     |
| ...

### ILO coverage
[Summary of which ILOs are covered — or note if placeholders were used]

### To do before submitting
- [ ] Verify ILO descriptions against module handbook
- [ ] Internal moderation
- [ ] Upload to shared OneDrive folder
```

---

## Reference files

- `references/ilo-mapping-template.md` — canonical ILO mapping table format and
  an example row for reference.
