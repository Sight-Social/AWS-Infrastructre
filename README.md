Whenever you create a new configuration, or checkout an existing configuration
from vcs, you need to initialize your working dir with ```terraform init```
- this downloads and installs the providers defined in the configuration

Next apply the configuration with the ```terraform apply``` command.

Use ```terraform destroy``` to do the opposite of terraform apply

use ```terraform show``` to display the values within your configuration