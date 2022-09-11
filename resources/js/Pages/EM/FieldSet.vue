<template>
    <div v-if="!field.repeatable" :id="name">
        <e-m-input
                v-for="(subField, subName) in field"
                v-if="!isNotFields.includes(subName)"
                :key="subName"
                :name="subField.name"
                :type="subField.type"
                :value="item[subField.name] || subField.value"
                :options="subField.options"
                :onclick="subField.onclick"
                :label="subField.label"
                :hasLabel="subField.hasLabel"
                :id="subField.name.toString().toKebabCase()"
                :isRequired="subField.required"
                :parenId="subField.parent_id"
                :show="subField.show"></e-m-input>
    </div>

    <div v-else class="space-y-3" :id="name">
        <div v-for="(subItem, subKey) in item[name]"
             class="p-2 mt-2 rounded-md bg-gradient-to-b from-indigo-100 to-white">
            <e-m-input
                    v-for="(subField, subName) in field"
                    v-if="!isNotFields.includes(subName)"
                    :key="subName"
                    :name="name + '[' + subKey + '][' + subField.name + ']'"
                    :type="subField.type"
                    :value="subItem[subField.name] || subField.value"
                    :options="subField.options"
                    :onclick="subField.onclick"
                    :label="subField.label"
                    :hasLabel="subField.hasLabel"
                    :id="subField.name.toString().toKebabCase()"
                    :isRequired="subField.required"
                    :parenId="subField.parent_id"
                    :show="subField.show"></e-m-input>

            <span :class="leftColumn"></span>
            <span :class="rightColumn">
                <e-m-button
                        type="button"
                        :originalText="__('Remove ' + name)"
                        customClass="hover:text-white hover:bg-indigo-500"
                        @click.native="removeItem(name, subKey)"></e-m-button>
            </span>
        </div>

        <span :class="leftColumn"></span>
        <span :class="rightColumn">
            <e-m-button
                    type="button"
                    :originalText="__('Add ' + name)"
                    customClass="hover:text-white hover:bg-indigo-500"
                    @click.native="addItem(name)"></e-m-button>
        </span>
    </div>
</template>

<script>
    import EMInput from './Input';
    import EMButton from './Button';

    export default {
        components: {
            EMInput,
            EMButton,
        },

        inject: [
            'leftColumn',
            'rightColumn',
        ],

        props: [
            'field',
            'name',
            'item',
            'controllerName',
        ],

        data() {
            return {
                isNotFields: ['type', 'show', 'repeatable'],
            };
        },

        methods: {
            addItem(fieldSetName) {
                this.$emit('addItem', fieldSetName);
            },

            removeItem(fieldSetName, index) {
                this.$emit('removeItem', fieldSetName, index);
            },
        },
    };
</script>