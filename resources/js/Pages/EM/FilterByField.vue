<template>
    <form :id="id" @submit.prevent="submit">
        <input type="hidden" name="value" :value="element.value"/>
        <input type="hidden" name="field" :value="element.field"/>
        <input type="hidden" name="action" :value="element.action"/>
        <input type="submit" :value="element.name" onclick="this.blur();"
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

        data()
        {
            return {
                id: (
                    this.element.field.replace(/_id|_/, '')
                    + '-'
                    + this.element.value.toLowerCase()
                ),
            };
        },

        methods: {
            submit()
            {
                const form = document.getElementById(this.id);
                this.$inertia.post('/' + this.controllerNames, new FormData(form));
            },
        },
    };
</script>