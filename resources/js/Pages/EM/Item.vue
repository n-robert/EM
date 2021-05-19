<template>
    <div class="p-2 m-4 bg-white shadow-xl sm:rounded-lg">
        <ul class="flex w-full">
            <li v-for="(fieldGroup, name) in formFields"
                v-if="fieldGroup.type === 'fieldgroup'"
                :class="selected[name] ? tabActive : tabInActive"
                @click="selectTab(name)"
                class="cursor-pointer w-full">
                <span>
                    {{__(name).toString().toPhrase()}}
                </span>
            </li>
        </ul>

        <div class="p-4 table w-full border-r border-b border-l rounded-b-lg bg-gray-100" :class="selected['id'] ? noTab : ''">
            <div v-for="(element, key) in formFields">
                <tab v-if="element.type === 'fieldgroup'"
                     :key="key"
                     :selected="selected[key]">
                    <div v-for="(field, name) in element"
                         v-if="!isNotFields.includes(name)"
                         class="table-row"
                         :class="name">
                        <field-set
                                v-if="field.type === 'fieldset'"
                                v-show="field.show"
                                :field="field"
                                :name="name"
                                :item="item"
                                :key="fieldSetKey"
                                :controllerName="controllerName"
                                @addItem="addItem"
                                @removeItem="removeItem"></field-set>

                        <fmsdocs-input v-else
                                       :name="field.name"
                                       :type="field.type"
                                       :value="item[field.name] || field.value"
                                       :options="field.options"
                                       :onclick="field.onclick"
                                       :label="field.label"
                                       :hasLabel="field.hasLabel"
                                       :id="field.name.toString().toKebabCase()"
                                       :isRequired="field.required"></fmsdocs-input>
                    </div>
                </tab>

                <div v-else class="table-row-group">
                    <div class="table-row">
                        <field-set
                                v-if="element.type === 'fieldset'"
                                v-show="element.show"
                                :field="element"
                                :name="key"
                                :item="item"
                                :key="fieldSetKey"
                                :controllerName="controllerName"
                                @addItem="addItem"
                                @removeItem="removeItem"></field-set>

                        <div v-else>
                            <fmsdocs-input :name="element.name"
                                           :type="element.type"
                                           :value="item[element.name] || element.value"
                                           :options="element.options"
                                           :label="element.label"
                                           :hasLabel="element.hasLabel"
                                           :id="element.name.toString().toKebabCase()"
                                           :isRequired="element.required"></fmsdocs-input>
                        </div>
                    </div>
                </div>
            </div>

            <slot></slot>
        </div>
    </div>
</template>

<script>
    import Tab from './Tab';
    import FieldSet from './FieldSet';
    import FmsdocsInput from './Input';

    export default {
        components: {
            Tab,
            FieldSet,
            FmsdocsInput,
        },

        inject: [
            'tabActive',
            'tabInActive',
            'noTab',
        ],

        props: [
            'item',
            'repeatable',
            'formFields',
            'requiredFields',
            'controllerName',
        ],

        data() {
            let selected = {};

            for (const key in this.formFields) {
                if (this.formFields.hasOwnProperty(key)) {
                    selected[key] = !!this.formFields[key]['show'];
                }
            }

            return {
                selected,
                isNotFields: ['type', 'show', 'repeatable'],
                fieldSetKey: 0,
            };
        },

        methods: {
            selectTab(fieldGroupName) {
                for (const index in this.selected) {
                    if (this.selected.hasOwnProperty(index)) {
                        this.selected[index] = (index === fieldGroupName);
                    }
                }
            },

            addItem(fieldSetName) {
                this.$emit('addItem', fieldSetName);
                this.fieldSetKey++;
            },

            removeItem(fieldSetName, index) {
                this.$emit('removeItem', fieldSetName, index);
                this.fieldSetKey++;
            },
        },
    };
</script>