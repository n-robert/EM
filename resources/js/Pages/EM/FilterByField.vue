<template>
    <form :ref="id" @submit.prevent="submit">
        <input type="hidden" name="name" :value="element.name"/>
        <input type="hidden" name="field" :value="element.field"/>
        <input type="hidden" name="value" :value="element.value"/>
        <input type="hidden" name="action" :value="element.action"/>
        <input type="submit"
               :value="element.field.endsWith('_date') ? formatDate(element.name) : __(element.name)"
               onclick="this.blur();"
               :class="{[filterFieldDefaultClass] : true, [filterFieldIsChecked] : element.checked }"/>
    </form>
</template>

<script>
export default {
    props: [
        'element',
    ],

    inject: [
        'filterFieldDefaultClass',
        'filterFieldIsChecked',
        'controllerNames',
    ],

    data() {
        return {
            id: (
                this.element.field.replace(/_id|_/, '')
                + '-'
                + this.element.value.toString().replace(/["\[\]]/gi, '').toLowerCase()
            ),
        };
    },

    methods: {
        submit() {
            this.$inertia.post('/' + this.controllerNames, new FormData(this.$refs[this.id]));
        },
    },
};
</script>
