start = (note / MiscLine)*

note =
    AnkiCodeBlockStarter

    config:(
        config:(!Config line:MiscLine {return line})*
        Config
        { return config }
    )?

    front:(!FrontBack !AnkiCodeBlockEnder line:MiscLine {return line})+
    FrontBack?

    back:(!AnkiCodeBlockEnder line: MiscLine {return line})*

    AnkiCodeBlockEnder
    {
        return {
            "type": "note",
            "config": config ? linesToStr(config) : null,
            "front": linesToStr(front),
            "back": linesToStr(back) || null,
            "location": location()
        }
    }

ConfigSeparator = '---'
Config = ConfigSeparator _* Newline

FrontBackSeparator = '==='
FrontBack = FrontBackSeparator _* Newline?

AnkiCodeBlockStarter = AnkiCodeBlockStart _* Newline
AnkiCodeBlockEnder = AnkiCodeBlockEnd _* Newline?
