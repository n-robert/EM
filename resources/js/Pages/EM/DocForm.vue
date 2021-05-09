<template>
    <form :id="id" :action="actionUri" method="post" target="_blank" @submit.prevent="submit">
        <div class="font-bold text-center">{{__(name.toString().toPhrase())}}</div>

        <div class="table">
            <slot name="upperFields"></slot>

            <div v-for="(attributes, key) in formFields" class="table-row">
                <fmsdocs-input v-if="attributes.type === 'hidden'"
                               :name="key"
                               :type="attributes.type"
                               :value="attributes.value"></fmsdocs-input>

                <div v-else-if="attributes.type === 'fieldset'" :id="key" v-show="attributes.show">
                    <div v-for="(fieldAttributes, fieldName) in attributes" v-if="!isNotFields.includes(fieldName)">
                        <fmsdocs-input
                                :name="fieldName"
                                :options="fieldAttributes.options"
                                :type="fieldAttributes.type"
                                :value="fieldAttributes.value"
                                :id="fieldName.toString().toKebabCase()"
                                :isRequired="fieldAttributes.required"
                                :checked="fieldAttributes.checked"
                                :onclick="fieldAttributes.onclick"></fmsdocs-input>
                    </div>
                </div>

                <div v-else>
                    <fmsdocs-input
                            v-if="!isNotFields.includes(key)"
                            :name="key"
                            :options="attributes.options"
                            :type="attributes.type"
                            :id="key.toString().toKebabCase()"
                            :value="attributes.value"
                            :isRequired="attributes.required"
                            :checked="attributes.checked"
                            :onclick="attributes.onclick"></fmsdocs-input>
                </div>
            </div>

            <slot name="lowerFields"></slot>

            <slot name="submit"></slot>
        </div>

        <input type="hidden" name="_token" :value="$page.props._token"/>
    </form>
</template>

<script>
    import FmsdocsLabel from './Label';
    import FmsdocsInput from './Input';
    import FmsdocsButton from './Button';

    export default {
        components: {
            FmsdocsLabel,
            FmsdocsInput,
            FmsdocsButton,
        },

        inject: [
            'controllerName',
        ],

        props: {
            name: {
                default: null,
            },
            itemId: {
                default: null,
            },
            modal: {
                default: {},
            },
        },

        data()
        {
            return {
                id: this.name + '-' + this.itemId,
                getFieldsUri: '/get-options/doc/' + this.controllerName + '/' + this.name + '/' + this.itemId,
                actionUri: '/print/' + this.name + '/' + this.itemId,
                formFields: {},
                requiredFields: [],
                isNotFields: ['type', 'show', 'repeatable'],
                errors: {},
            };
        },

        mounted()
        {
            const axios = require('axios');

            axios.post(this.getFieldsUri).then(response => {
                this.formFields = response.data;

                this.requiredFields = this.formFields.requiredFields;
                delete this.formFields.requiredFields;
            });
        },

        computed: {
            console: () => console,
        },

        methods: {
            submit()
            {
                if (!validateRequiredFields(this.requiredFields, this.$el, this.errors)) {
                    return false;
                }

                this.$emit('closeModalFromDocForm', this.name.toPascalCase());
                this.$emit('addFieldStateFromDocForm', this.name.toPascalCase(), this.itemId);
                document.getElementById(this.id).submit();
            },
        },

//        watch: {
//            errors: {
//                immediate: true,
//                handler: function (newVal, oldVal) {
//                    console.log('new: %s, old: %s', newVal, oldVal);
//                },
//            },
//        },
    };
</script>