FROM left4devops/l4d2

# Create the target directory in the container
RUN mkdir -p "/home/louis/l4d2/left4dead2/ems/admin system/"
RUN mkdir -p "/home/louis/l4d2/left4dead2/ems/left4bots/cfg/"

# Copy the initial admins.txt file from the host to the container
COPY --chown=louis ["./admins.txt", "/home/louis/l4d2/left4dead2/ems/admin system/admins.txt"]

# Left 4 Bots
COPY --chown=louis ["./admins.txt", "/home/louis/l4d2/left4dead2/ems/left4bots/cfg/admins.txt"]
COPY --chown=louis ["./left4bots/settings.txt", "/home/louis/l4d2/left4dead2/ems/left4bots/cfg/settings.txt"]
