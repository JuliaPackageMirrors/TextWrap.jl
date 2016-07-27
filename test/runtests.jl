module TextWrapTest

using TextWrap
using Base.Test
using Compat

text = """
    Julia is a high-level, high-performance dynamic programming language
    for technical computing, with syntax that is familiar to users of
    other technical computing environments. It provides a sophisticated
    compiler, distributed parallel execution, numerical accuracy, and an
    extensive mathematical function library."""

@test wrap(text) == """
    Julia is a high-level, high-performance dynamic programming language
    for technical computing, with syntax that is familiar to users of
    other technical computing environments. It provides a sophisticated
    compiler, distributed parallel execution, numerical accuracy, and an
    extensive mathematical function library."""

@test wrap(text, width=30) == """
    Julia is a high-level, high-
    performance dynamic
    programming language for
    technical computing, with
    syntax that is familiar to
    users of other technical
    computing environments. It
    provides a sophisticated
    compiler, distributed parallel
    execution, numerical accuracy,
    and an extensive mathematical
    function library."""

@test wrap(text, width=30, fix_sentence_endings=true, break_on_hyphens=false) == """
    Julia is a high-level,
    high-performance dynamic
    programming language for
    technical computing, with
    syntax that is familiar to
    users of other technical
    computing environments.  It
    provides a sophisticated
    compiler, distributed parallel
    execution, numerical accuracy,
    and an extensive mathematical
    function library."""

@test wrap(text, width=30, initial_indent=2, subsequent_indent=0) == """
      Julia is a high-level, high-
    performance dynamic
    programming language for
    technical computing, with
    syntax that is familiar to
    users of other technical
    computing environments. It
    provides a sophisticated
    compiler, distributed parallel
    execution, numerical accuracy,
    and an extensive mathematical
    function library."""

@test wrap(text, width=32, initial_indent=">   ", subsequent_indent="> ") == """
    >   Julia is a high-level, high-
    > performance dynamic
    > programming language for
    > technical computing, with
    > syntax that is familiar to
    > users of other technical
    > computing environments. It
    > provides a sophisticated
    > compiler, distributed parallel
    > execution, numerical accuracy,
    > and an extensive mathematical
    > function library."""

tabtext = "aaaaaaa\tbbbbbbb\t\ncccccc\tddddd\teeee  \tfff\tgg\th\n"

@test wrap(tabtext, width=20, replace_whitespace=true,  expand_tabs=true) ==
    "aaaaaaa bbbbbbb\ncccccc  ddddd   eeee\nfff     gg      h"
@test wrap(tabtext, width=20, replace_whitespace=false, expand_tabs=true) ==
    "aaaaaaa bbbbbbb\ncccccc  ddddd   eeee\nfff     gg      h"
@test wrap(tabtext, width=20, replace_whitespace=true,  expand_tabs=false) ==
    "aaaaaaa bbbbbbb\ncccccc ddddd eeee\nfff gg h"
@test wrap(tabtext, width=20, replace_whitespace=false, expand_tabs=false) ==
    "aaaaaaa\tbbbbbbb\ncccccc\tddddd\teeee\nfff\tgg\th"

longwordstext = """
    The 45-letter word pneumonoultramicroscopicsilicovolcanoconiosis is the longest English word that appears in a major dictionary. A 79 letter word,
    Donaudampfschiffahrtselektrizitätenhauptbetriebswerkbauunterbeamtengesellschaft, was named the longest published word in the German language by the 1996 Guinness Book of
    World Records, but longer words are possible. In his comedy Assemblywomen (c. 392 BC) Aristophanes coined the 171-letter word
    λοπαδοτεμαχοσελαχογαλεοκρανιολειψανοδριμυποτριμματοσιλφιοκαραβομελιτοκατακεχυμενοκιχλεπικοσσυφοφαττοπεριστεραλεκτρυονοπτοκεφαλλιοκιγκλοπελειολαγῳοσιραιοβαφητραγανοπτερύγων.
    The longest Hebrew word is the 25-letter-long (including vowels) וכשלאנציקלופדיותינו (u'chshelentsiklopedioténu), which means 'and when our encyclopedias will have....'"""

@test wrap(longwordstext, width=172) == """
    The 45-letter word pneumonoultramicroscopicsilicovolcanoconiosis is the longest English word that appears in a major dictionary. A 79 letter word,
    Donaudampfschiffahrtselektrizitätenhauptbetriebswerkbauunterbeamtengesellschaft, was named the longest published word in the German language by the 1996 Guinness Book of
    World Records, but longer words are possible. In his comedy Assemblywomen (c. 392 BC) Aristophanes coined the 171-letter word
    λοπαδοτεμαχοσελαχογαλεοκρανιολειψανοδριμυποτριμματοσιλφιοκαραβομελιτοκατακεχυμενοκιχλεπικοσσυφοφαττοπεριστεραλεκτρυονοπτοκεφαλλιοκιγκλοπελειολαγῳοσιραιοβαφητραγανοπτερύγων.
    The longest Hebrew word is the 25-letter-long (including vowels) וכשלאנציקלופדיותינו (u'chshelentsiklopedioténu), which means 'and when our encyclopedias will have....'"""

@test wrap(longwordstext, width=171) == """
    The 45-letter word pneumonoultramicroscopicsilicovolcanoconiosis is the longest English word that appears in a major dictionary. A 79 letter word,
    Donaudampfschiffahrtselektrizitätenhauptbetriebswerkbauunterbeamtengesellschaft, was named the longest published word in the German language by the 1996 Guinness Book of
    World Records, but longer words are possible. In his comedy Assemblywomen (c. 392 BC) Aristophanes coined the 171-letter word λοπαδοτεμαχοσελαχογαλεοκρανιολειψανοδριμυποτρ
    ιμματοσιλφιοκαραβομελιτοκατακεχυμενοκιχλεπικοσσυφοφαττοπεριστεραλεκτρυονοπτοκεφαλλιοκιγκλοπελειολαγῳοσιραιοβαφητραγανοπτερύγων. The longest Hebrew word is the 25-letter-
    long (including vowels) וכשלאנציקלופדיותינו (u'chshelentsiklopedioténu), which means 'and when our encyclopedias will have....'"""

@test wrap(longwordstext, width=80) == """
    The 45-letter word pneumonoultramicroscopicsilicovolcanoconiosis is the longest
    English word that appears in a major dictionary. A 79 letter word,
    Donaudampfschiffahrtselektrizitätenhauptbetriebswerkbauunterbeamtengesellschaft,
    was named the longest published word in the German language by the 1996 Guinness
    Book of World Records, but longer words are possible. In his comedy
    Assemblywomen (c. 392 BC) Aristophanes coined the 171-letter word λοπαδοτεμαχοσε
    λαχογαλεοκρανιολειψανοδριμυποτριμματοσιλφιοκαραβομελιτοκατακεχυμενοκιχλεπικοσσυφ
    οφαττοπεριστεραλεκτρυονοπτοκεφαλλιοκιγκλοπελειολαγῳοσιραιοβαφητραγανοπτερύγων.
    The longest Hebrew word is the 25-letter-long (including vowels)
    וכשלאנציקלופדיותינו (u'chshelentsiklopedioténu), which means 'and when our
    encyclopedias will have....'"""

@test wrap(longwordstext, width=79) == """
    The 45-letter word pneumonoultramicroscopicsilicovolcanoconiosis is the longest
    English word that appears in a major dictionary. A 79 letter word, Donaudampfsc
    hiffahrtselektrizitätenhauptbetriebswerkbauunterbeamtengesellschaft, was named
    the longest published word in the German language by the 1996 Guinness Book of
    World Records, but longer words are possible. In his comedy Assemblywomen (c.
    392 BC) Aristophanes coined the 171-letter word λοπαδοτεμαχοσελαχογαλεοκρανιολε
    ιψανοδριμυποτριμματοσιλφιοκαραβομελιτοκατακεχυμενοκιχλεπικοσσυφοφαττοπεριστεραλ
    εκτρυονοπτοκεφαλλιοκιγκλοπελειολαγῳοσιραιοβαφητραγανοπτερύγων. The longest
    Hebrew word is the 25-letter-long (including vowels) וכשלאנציקלופדיותינו
    (u'chshelentsiklopedioténu), which means 'and when our encyclopedias will
    have....'"""

@test wrap(longwordstext, width=45) == """
    The 45-letter word
    pneumonoultramicroscopicsilicovolcanoconiosis
    is the longest English word that appears in a
    major dictionary. A 79 letter word, Donaudamp
    fschiffahrtselektrizitätenhauptbetriebswerkba
    uunterbeamtengesellschaft, was named the
    longest published word in the German language
    by the 1996 Guinness Book of World Records,
    but longer words are possible. In his comedy
    Assemblywomen (c. 392 BC) Aristophanes coined
    the 171-letter word λοπαδοτεμαχοσελαχογαλεοκρ
    ανιολειψανοδριμυποτριμματοσιλφιοκαραβομελιτοκ
    ατακεχυμενοκιχλεπικοσσυφοφαττοπεριστεραλεκτρυ
    ονοπτοκεφαλλιοκιγκλοπελειολαγῳοσιραιοβαφητραγ
    ανοπτερύγων. The longest Hebrew word is the
    25-letter-long (including vowels)
    וכשלאנציקלופדיותינו
    (u'chshelentsiklopedioténu), which means 'and
    when our encyclopedias will have....'"""

@test wrap(longwordstext, width=44) == """
    The 45-letter word pneumonoultramicroscopics
    ilicovolcanoconiosis is the longest English
    word that appears in a major dictionary. A
    79 letter word, Donaudampfschiffahrtselektri
    zitätenhauptbetriebswerkbauunterbeamtengesel
    lschaft, was named the longest published
    word in the German language by the 1996
    Guinness Book of World Records, but longer
    words are possible. In his comedy
    Assemblywomen (c. 392 BC) Aristophanes
    coined the 171-letter word λοπαδοτεμαχοσελαχ
    ογαλεοκρανιολειψανοδριμυποτριμματοσιλφιοκαρα
    βομελιτοκατακεχυμενοκιχλεπικοσσυφοφαττοπερισ
    τεραλεκτρυονοπτοκεφαλλιοκιγκλοπελειολαγῳοσιρ
    αιοβαφητραγανοπτερύγων. The longest Hebrew
    word is the 25-letter-long (including
    vowels) וכשלאנציקלופדיותינו
    (u'chshelentsiklopedioténu), which means
    'and when our encyclopedias will have....'"""

@test wrap(longwordstext, width=19) == """
    The 45-letter word
    pneumonoultramicros
    copicsilicovolcanoc
    oniosis is the
    longest English
    word that appears
    in a major
    dictionary. A 79
    letter word, Donaud
    ampfschiffahrtselek
    trizitätenhauptbetr
    iebswerkbauunterbea
    mtengesellschaft,
    was named the
    longest published
    word in the German
    language by the
    1996 Guinness Book
    of World Records,
    but longer words
    are possible. In
    his comedy
    Assemblywomen (c.
    392 BC)
    Aristophanes coined
    the 171-letter word
    λοπαδοτεμαχοσελαχογ
    αλεοκρανιολειψανοδρ
    ιμυποτριμματοσιλφιο
    καραβομελιτοκατακεχ
    υμενοκιχλεπικοσσυφο
    φαττοπεριστεραλεκτρ
    υονοπτοκεφαλλιοκιγκ
    λοπελειολαγῳοσιραιο
    βαφητραγανοπτερύγων
    . The longest
    Hebrew word is the
    25-letter-long
    (including vowels)
    וכשלאנציקלופדיותינו
    (u'chshelentsiklope
    dioténu), which
    means 'and when our
    encyclopedias will
    have....'"""

@test wrap(longwordstext, width=18) == """
    The 45-letter word
    pneumonoultramicro
    scopicsilicovolcan
    oconiosis is the
    longest English
    word that appears
    in a major
    dictionary. A 79
    letter word, Donau
    dampfschiffahrtsel
    ektrizitätenhauptb
    etriebswerkbauunte
    rbeamtengesellscha
    ft, was named the
    longest published
    word in the German
    language by the
    1996 Guinness Book
    of World Records,
    but longer words
    are possible. In
    his comedy
    Assemblywomen (c.
    392 BC)
    Aristophanes
    coined the
    171-letter word λο
    παδοτεμαχοσελαχογα
    λεοκρανιολειψανοδρ
    ιμυποτριμματοσιλφι
    οκαραβομελιτοκατακ
    εχυμενοκιχλεπικοσσ
    υφοφαττοπεριστεραλ
    εκτρυονοπτοκεφαλλι
    οκιγκλοπελειολαγῳο
    σιραιοβαφητραγανοπ
    τερύγων. The
    longest Hebrew
    word is the
    25-letter-long
    (including vowels)
    וכשלאנציקלופדיותינ
    ו (u'chshelentsikl
    opedioténu), which
    means 'and when
    our encyclopedias
    will have....'"""

@test wrap(longwordstext, width=18, break_long_words=false) == """
    The 45-letter word
    pneumonoultramicroscopicsilicovolcanoconiosis
    is the longest
    English word that
    appears in a major
    dictionary. A 79
    letter word,
    Donaudampfschiffahrtselektrizitätenhauptbetriebswerkbauunterbeamtengesellschaft,
    was named the
    longest published
    word in the German
    language by the
    1996 Guinness Book
    of World Records,
    but longer words
    are possible. In
    his comedy
    Assemblywomen (c.
    392 BC)
    Aristophanes
    coined the
    171-letter word
    λοπαδοτεμαχοσελαχογαλεοκρανιολειψανοδριμυποτριμματοσιλφιοκαραβομελιτοκατακεχυμενοκιχλεπικοσσυφοφαττοπεριστεραλεκτρυονοπτοκεφαλλιοκιγκλοπελειολαγῳοσιραιοβαφητραγανοπτερύγων.
    The longest Hebrew
    word is the
    25-letter-long
    (including vowels)
    וכשלאנציקלופדיותינו
    (u'chshelentsiklopedioténu),
    which means 'and
    when our
    encyclopedias will
    have....'"""

tmpf = tempname()
try
    open(tmpf, "w") do f
        print_wrapped(f, text, width=30, fix_sentence_endings=true, break_on_hyphens=false)
    end
    @test readstring(tmpf) == """
        Julia is a high-level,
        high-performance dynamic
        programming language for
        technical computing, with
        syntax that is familiar to
        users of other technical
        computing environments.  It
        provides a sophisticated
        compiler, distributed parallel
        execution, numerical accuracy,
        and an extensive mathematical
        function library."""

    open(tmpf, "w") do f
        println_wrapped(f, text, width=30, fix_sentence_endings=true, break_on_hyphens=false)
    end
    @test readstring(tmpf) == """
        Julia is a high-level,
        high-performance dynamic
        programming language for
        technical computing, with
        syntax that is familiar to
        users of other technical
        computing environments.  It
        provides a sophisticated
        compiler, distributed parallel
        execution, numerical accuracy,
        and an extensive mathematical
        function library.
        """

    open(tmpf, "w") do f
        println_wrapped(f, width=30, fix_sentence_endings=true, break_on_hyphens=false)
    end
    @test readstring(tmpf) == "\n"

    if VERSION >= v"0.3-"
        open(tmpf, "w") do f
            bk_STDOUT = STDOUT
            try
                redirect_stdout(f)
                print_wrapped(text, width=30, fix_sentence_endings=true, break_on_hyphens=false)
            finally
                redirect_stdout(bk_STDOUT)
            end
        end
        @test readstring(tmpf) == """
            Julia is a high-level,
            high-performance dynamic
            programming language for
            technical computing, with
            syntax that is familiar to
            users of other technical
            computing environments.  It
            provides a sophisticated
            compiler, distributed parallel
            execution, numerical accuracy,
            and an extensive mathematical
            function library."""
    end
finally
    isfile(tmpf) && rm(tmpf)
end

macro backwardscompatible_test_throws(args...)
    if VERSION >= v"0.3-"
        :(@test_throws($(esc(args[1])), $(esc(args[2]))))
    else
        :(@test_throws($(esc(args[2]))))
    end
end

@backwardscompatible_test_throws ErrorException wrap("", initial_indent=10, width=10)
@backwardscompatible_test_throws ErrorException wrap("", subsequent_indent=10, width=10)
@backwardscompatible_test_throws ErrorException wrap("", initial_indent="~~~~~~~~~~", width=10)
@backwardscompatible_test_throws ErrorException wrap("", subsequent_indent="~~~~~~~~~~", width=10)

end
