<template>
    <div v-if="!field.repeatable" :id="name">
        <em-input
            v-for="(subField, subName) in field"
            v-if="!isNotFields.includes(subName)"
            :key="subName"
            :name="subField.name"
            :type="subField.type"
            :disabled="subField.disabled"
            :value="item[subField.name] || subField.value"
            :options="subField.options"
            :onclick="subField.onclick"
            :label="subField.label"
            :hasLabel="subField.hasLabel"
            :id="subField.name.toString().toKebabCase()"
            :isRequired="subField.required"
            :parenId="subField.parent_id"
            :show="subField.show"></em-input>
    </div>

    <div v-else class="space-y-3" :id="name">
        <div v-for="(subItem, subKey) in item[name]"
             class="py-2 pr-2 mt-2 rounded-md bg-gradient-to-b from-indigo-100 to-white">
            <em-input
                v-for="(subField, subName) in field"
                v-if="!isNotFields.includes(subName)"
                :key="subName"
                :name="name + '[' + subKey + '][' + subField.name + ']'"
                :type="subField.type"
                :disabled="subField.disabled"
                :value="subItem[subField.name] || subField.value"
                :options="subField.options"
                :onclick="subField.onclick"
                :label="subField.label"
                :hasLabel="subField.hasLabel"
                :id="(name + '-' + subKey + '-' + subField.name).toString().toKebabCase()"
                :isRequired="subField.required"
                :parenId="subField.parent_id"
                :show="subField.show"
                :error="errors[name + '.' + subKey + '.' + subField.name]"></em-input>

            <span :class="leftColumn"></span>
            <span :class="rightColumn">
                <em-button
                    v-if="field.deletable || $page.props.isAdmin"
                    type="button"
                    :originalText="__('Remove ' + name)"
                    customClass="hover:text-white hover:bg-indigo-500"
                    @click.native="removeItem(name, subKey)"></em-button>
            </span>
        </div>

        <span :class="leftColumn"></span>
        <span :class="rightColumn">
            <em-button
                type="button"
                :originalText="__('Add ' + name)"
                customClass="hover:text-white hover:bg-indigo-500"
                @click.native="addItem(name)"></em-button>
        </span>
    </div>
</template>

<script>
import EmInput from './Input';
import EmButton from './Button';

export default {
    components: {
        EmInput,
        EmButton,
    },

    inject: [
        'leftColumn',
        'rightColumn',
    ],

    props: {
        field: {
            default: null,
        },
        name: {
            default: null,
        },
        item: {
            default: null,
        },
        controllerName: {
            default: null,
        },
        errors: {
            default: null,
        },
    },

    data() {
        return {
            isNotFields: ['type', 'show', 'repeatable', 'deletable'],
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
