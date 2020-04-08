FROM lab_ws_base:latest

# PREP global bashrc
COPY bashrc_add /tmp
RUN cat /tmp/bashrc_add >> /etc/skel/.bashrc

# Create user(s)
RUN useradd -c "User01 Surname01" -m -s /bin/bash user01

# Set user passwords
RUN echo "user01:Password123" | chpasswd

# Prep service
COPY service.sh /opt
RUN chmod 700 /opt/service.sh

# Add your other custom stuff here...

# Create a useless service
CMD /opt/service.sh
