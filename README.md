## Method 1: Using `sed` (No Installation Required)

```bash
sed -i 's/\r$//' install-env.sh
```

## Method 2:Using `dos2unix`

```bash
sudo apt install -y dos2unix
dos2unix install-env.sh
```
## Run the Script

```
chmod +x install-env.sh
./install-env.sh
```
