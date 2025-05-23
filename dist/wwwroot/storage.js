window.transactionStorage = {
    save: function (key, value) {
        localStorage.setItem(key, JSON.stringify(value));
    },
    load: function (key) {
        const value = localStorage.getItem(key);
        return value ? JSON.parse(value) : [];
    }
};