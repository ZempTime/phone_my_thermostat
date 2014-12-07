in your terminal

```ruby
touch config/secrets.yml

rake secret 

#(copy the key)
```

in secrets.yml

```ruby
development:
  secret_key_base: #paste key here
```

