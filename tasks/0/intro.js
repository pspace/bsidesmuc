Interceptor.attach(ptr("ADDRESS"), {
    onEnter: function(args) {
        args[0] = ptr("1338");
    }
});
