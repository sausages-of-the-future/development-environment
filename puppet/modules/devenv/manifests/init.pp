class devenv {

    include devenv::libs
    include devenv::tools
    include devenv::python
    include devenv::ruby
    include devenv::nginx
    include devenv::mongo
    #include devenv::java
    #include devenv::postgres
    include devenv::redis
    #include devenv::elasticsearch

}
