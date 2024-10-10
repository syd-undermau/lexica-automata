with open("chief_officers_lower.ahk",  "r", encoding="utf-8") as f:
        with open("chief_officers_title.ahk", "w", encoding="utf-8") as out:
            for line in f:
                if line.count("::") > 0:
                    parts = line.split("::")
                    out.write("::" + parts[1] + "::" + " ".join([word.title() for word in parts[2].split(" ")]))
                else:
                    out.write(line)