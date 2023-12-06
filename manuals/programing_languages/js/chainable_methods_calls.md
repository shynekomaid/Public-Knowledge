# Method Chaining in JavaScript

## Table of Contents

- [Method Chaining in JavaScript](#method-chaining-in-javascript)
  - [Table of Contents](#table-of-contents)
  - [Using Classes](#using-classes)
  - [Without Classes](#without-classes)

## Using Classes

Method chaining can be achieved by ensuring each method in the chain returns the object instance, allowing for another method to be invoked right after. Here's how:

```javascript
class Holder {
    constructor() {
        this.data = [];
    }

    run() {
        console.log("Running...");
        return this;  // Enables chaining
    }

    push() {
        this.data.push("New data");
        console.log("Pushed new data");
        return this;  // Enables chaining
    }
}

const holder = new Holder();
holder.run().push();  // Output: Running... Pushed new data
holder.push().run();  // Output: Pushed new data Running...
```

## Without Classes

If you prefer not to use classes, you can achieve method chaining with plain objects:

```javascript
function createHolder() {
    const holder = {
        data: [],

        run: function() {
            console.log("Running...");
            return this;  // Enables chaining
        },

        push: function() {
            this.data.push("New data");
            console.log("Pushed new data");
            return this;  // Enables chaining
        }
    };
    return holder;
}

const holder = createHolder();
holder.run().push();  // Output: Running... Pushed new data
holder.push().run();  // Output: Pushed new data Running...
```

Tags: #js
