# README

## NOTE:

username="kafka"        # (A) outbound identity
password="kafka"        # (B) password for (A)
user_kafka="kafka"      # (C) inbound user: name=kafka
user_client="kafka"     # (D) inbound user: name=client

Accept incoming connections from a user named "kafka" with password "kafka",
and from a user named "client" with password "kafka".
