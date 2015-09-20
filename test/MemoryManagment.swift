//automatic reference counting, is similar to other languages that uses garbage collectors
//prefix variables with weak if you need objects to reference each other
//you can also use the prefix unknown if you set the reference from the initializer
//NOTE: you set the variable to nil once you dont need it anymore
//you can test if the object has been removed by adding a print call in an dei it method inside the class