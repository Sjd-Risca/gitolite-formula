# gitolite-formula
Saltstack formula for gitolite.

Beside the default values, already shown in pillar.example, it is required to set a public key in:

.. code:: 
  gitolite:
    adminkey: my-public-ssh-rsa-key

# Modules

## users-formula
The user configuration is done with the users-formula. Please execute it with the following options:
