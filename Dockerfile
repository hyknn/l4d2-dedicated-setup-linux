FROM left4devops/l4d2

# Create the target directory in the container
RUN mkdir -p "/home/louis/l4d2/left4dead2/ems/admin system/"
RUN mkdir -p "/home/louis/l4d2/left4dead2/ems/left4bots/cfg/"

# Copy the initial admins.txt file from the host to the container
COPY ["./admins.txt", "/home/louis/l4d2/left4dead2/ems/admin system/admins.txt"]
COPY ["./admins.txt", "/home/louis/l4d2/left4dead2/ems/left4bots/cfg/admins.txt"]
