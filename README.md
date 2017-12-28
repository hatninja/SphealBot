# SphealBot
My personal bot that I run for my discord server.

It uses [Discordia](https://github.com/SinisterRectus/Discordia), which is based on Luvit and LuaJIT.

It's functionality is entirely determined by it's commands, which you can think of as services.

These "services" can choose to appear on the bot's help list, have global functionality, or access various callbacks such as a regular messages or commands.

## Installation

1. Install [Luvit](https://luvit.io/install.html), along with [Discordia](https://github.com/SinisterRectus/Discordia).  
2. Put your bot token in a new file called `token.txt` at the project root.  
3. Then run with `luvit /path/to/SphealBot` and you should be good to go!