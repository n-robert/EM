<template>
    <div v-if="!field.repeatable">
        <div v-for="(subField, subName) in field" v-if="!isNotFields.includes(subName)">
            <fmsdocs-input
                    :name="subField.name"
                    :type="subField.type"
                    :value="item[subField.name] || subField.value"
                    :options="subField.options"
                    :onclick="subField.onclick"
                    :label="subField.label"
                    :hasLabel="subField.hasLabel"
                    :id="subField.name.toString().toKebabCase()"
                    :isRequired="subField.required"></fmsdocs-input>
        </div>
    </div>

    <div v-else class="space-y-3">
        <div v-for="(subItem, subKey) in item[name]" class="border rounded-md bg-gray-100">
            <div v-for="(subField, subName) in field" v-if="!isNotFields.includes(subName)">
                <fmsdocs-input
                        :name="name + '[' + subKey + '][' + subField.name + ']'"
                        :type="subField.type"
                        :value="subItem[subField.name] || subField.value"
                        :options="subField.options"
                        :onclick="subField.onclick"
                        :label="subField.label"
                        :hasLabel="subField.hasLabel"
                        :id="subField.name.toString().toKebabCase()"
                        :isRequired="subField.required"></fmsdocs-input>
            </div>

            <fmsdocs-input
                    type="button"
                    :value="__('Remove')"
                    hasLabel="false"
                    @click.native="removeItem(name, subKey)"></fmsdocs-input>
        </div>

        <fmsdocs-input
                type="button"
                :value="__('Add')"
                hasLabel="false"
                @click.native="addItem(name)"></fmsdocs-input>
    </div>
</template>

<script>
    import FmsdocsInput from './Input';

    export default {
        components: {
            FmsdocsInput,
        },

        props: [
            'field',
            'name',
            'item',
        ],

        data() {
            return {
                isNotFields: ['type', 'show', 'repeatable'],
            };
        },

        methods: {
            addItem(key) {
                this.$emit('addItem', key);
            },

            removeItem(key, index) {
                this.$emit('removeItem', key, index);
            },
        },
    };
</script>