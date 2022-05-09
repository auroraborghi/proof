def say_hello(name: str) -> None:
    """
    Says hello to the specified user.

    :param name: Contains the name of the user.
    """

    print('Hello, ' + name)

    # I am the root module.
    # I am loaded first and then all my submodules are loaded.
