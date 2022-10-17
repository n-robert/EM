module.exports = {
    methods: {
        /**
         * Translate the given key.
         */
        __(key, replace = {}) {
            let translation = this.$page.props.language[key] ?? key;

            Object.keys(replace).forEach(function (k) {
                translation = translation.replace(':' + k, replace[k]);
            });

            return translation;
        },

        /**
         * Translate the given key with basic pluralization.
         */
        __n(key, number, replace = {}) {
            const options = key.split('|');

            key = options[1];

            if (number === 1) {
                key = options[0];
            }

            return this.__(key, replace);
        },

        formatDate(date, format = 'YYYY-MM-DD') {
            let
                delimiters = ['-', '.', '/'],
                currentDelimiter = this.getDelimiter(this.$page.props.defaultDateFormat, delimiters);

            if (date && currentDelimiter) {
                const defaultOrder = this.getYearMonthDayOrder(this.$page.props.defaultDateFormat, currentDelimiter);
                let currentDateArray = date.split(currentDelimiter);

                if (Object.keys(defaultOrder).length === 3 && currentDateArray.length === 3) {
                    const
                        newDelimiter = this.getDelimiter(format, delimiters),
                        newOrder = this.getYearMonthDayOrder(format, newDelimiter);
                    let newDateArray = [];

                    Object.keys(newOrder).forEach(value => {
                        newDateArray.push(currentDateArray[defaultOrder[value]]);
                    });

                    return newDateArray.join(newDelimiter);
                }
            }

            return date;
        },

        getDelimiter(date, delimiters) {
            let delimiter;

            for (const char of delimiters) {
                if (date.indexOf(char) !== -1) {
                    delimiter = char;
                    break;
                }
            }

            return delimiter;
        },

        getYearMonthDayOrder(format, delimiter) {
            let order = {};

            format.split(delimiter).forEach((value, index) => {
                switch (value.toLowerCase()) {
                    case 'yyyy':
                        order['yearPos'] = index;
                        break;
                    case 'mm':
                        order['monthPos'] = index;
                        break;
                    case 'dd':
                        order['dayPos'] = index;
                        break;
                }
            });

            return order;
        },

        validateRequiredFields(requiredFields, el, errors) {
            requiredFields.forEach(id => {
                    const field = el.querySelector('[name="' + id + '"]');

                    if (!field.value) {
                        errors[id] = true;
                    } else {
                        delete errors[id];
                    }
                },
            );

            return Object.keys(errors).length === 0;
        },
    },
};

String.prototype.toLowerCaseArray = function (smart = false) {
    let pattern = /(\(?)([A-ZА-Я]+(?=[A-ZА-Я][a-zа-я]+[0-9]*|\b)|[A-ZА-Я]?[a-zа-я]+[0-9]*|[A-ZА-Я]+|[0-9]+)(\)?)/g;
    return this
        .match(pattern)
        .map(word => smart && (/(\(?)([A-ZА-Я]+)(\)?)/).test(word) ? word : word.toLowerCase());
};

String.prototype.pluralize = function () {
    return (this + 's')
        .replace(/ys$/, 'ies')
        .replace(/ss$/, 'ses')
        .replace(/(staff)s$/i, '$1');
};

String.prototype.ucFirst = function () {
    return this.replace(/^./, chr => chr.toUpperCase());
};

String.prototype.toPhrase = function (smart = false) {
    return this.toLowerCaseArray(smart).join(' ').ucFirst();
};

String.prototype.toSnakeCase = function (smart = false) {
    return this.toLowerCaseArray(smart).join('_');
};

String.prototype.toKebabCase = function (smart = false) {
    return this.toLowerCaseArray(smart).join('-');
};

String.prototype.toPascalCase = function (smart = false) {
    return this.toLowerCaseArray(smart).map(word => word.ucFirst()).join('');
};

toggleVisibility = function (id, checked = true, parent = null) {
    if (parent) {
        document.getElementById(parent).childNodes.forEach(el => {
            if (el.style) {
                el.style.display = 'none';
            }
        });
    }

    document.getElementById(id).style.display = checked ? 'block' : 'none';
};
