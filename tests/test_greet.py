from footnotes import greet, main


def test_greet_default():
    assert greet() == "Hello, world!"


def test_greet_name():
    assert greet("Footnotes") == "Hello, Footnotes!"


def test_main_prints_greeting(capsys):
    main()
    assert capsys.readouterr().out == "Hello, world!\n"
