# Scripts

The `add-to-cart.sh` script can be used to generate some interactions for the `carts` service by adding items to the shopping cart.

## Usage

### Get the IP of the carts service

```
$ kubectl get svc -n prod
```

### Run the script

Run the script with the following command (replace the IP with the IP address of your `carts` service):

```
$ ./add-to-cart.sh http://XX.XX.XX.XX/carts/1/items
```

