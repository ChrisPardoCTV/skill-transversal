Generate a skills bundle for the specified team by reading all SKILL.md files and producing a single compiled markdown file optimized for Claude Project Knowledge upload.

## Arguments

`$ARGUMENTS` is the team name (e.g. `product`, `design`) or `all` to generate bundles for every team.

## Instructions

1. **Resolve target teams**
   - If `$ARGUMENTS` is `all`: find all directories in `skills/` that don't start with `_`
   - Otherwise: use `$ARGUMENTS` as the single team name
   - Validate each team directory exists under `skills/`. If not, report the error and stop.

2. **For each team, read all skills**
   - List all subdirectories in `skills/{team}/`
   - For each subdirectory, read its `SKILL.md`
   - Extract from frontmatter: `name`, `description` (first line only, before Trigger/Activador), `version`, trigger line (the line starting with `Trigger:` or `Activador:`)
   - Read the full body (everything after the closing `---` of the frontmatter)

3. **Generate the bundle content**

   Use this exact structure:

   ```
   # Skills Bundle — {Team capitalized}
   > Team: {team} · Generated: {today's date YYYY-MM-DD} · {git short hash}
   > Source: https://github.com/ChrisPardoCTV/skill-transversal

   ## How to use this file

   Upload this file to your Claude Project as **Project Knowledge** — Claude will apply the skills automatically when it detects the right context. No further action needed.

   **To update:** when the team pushes changes, replace this file in your Project Knowledge with the new version.

   ## Skills Index

   | Skill | Description | Activates when... |
   |-------|-------------|-------------------|
   | `{name}` | {description} | {trigger} |
   ... one row per skill ...


   ---

   # Skill: {name}
   > v{version}

   {full skill body, with assets/ references replaced by "(see team documentation)"}

   ---

   ... repeat for each skill ...
   ```

4. **Handle assets and cross-references**
   - Any reference to `assets/` paths: replace with `*(see team documentation)*`
   - Preserve all other content verbatim — tables, code blocks, examples, everything

5. **Write the output**
   - Get git short hash by running: `git rev-parse --short HEAD`
   - Write to `dist/{team}/skills-bundle.md` (create the directory if needed)
   - Report: team name, number of skills included, output path, file size

6. **If `all` was specified**, repeat steps 2–5 for each team and show a final summary table.
