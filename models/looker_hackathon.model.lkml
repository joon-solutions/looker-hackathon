# Define the database connection to be used for this model.
connection: "joon-sandbox"
include: "/views/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: looker_hackathon_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: looker_hackathon_default_datagroup

explore: order_items {
  label: "E-commerce order"
  fields: [
    order_items.order_id,
    order_items.total_sales,
    order_items.total_orders,
    order_items.total_customers,
    order_items.avo,
    orders.created_month,
    orders.created_date,
    orders.created_week,
    orders.created_quarter,
    products.product_category,
    products.product_brand,
    products.product_name,
    users.age,
    users.age_group
  ]
  join: orders {
    relationship: many_to_one
    type: inner
    sql_on: ${order_items.order_id} = ${orders.order_id} ;;
  }
  join: products {
    relationship: many_to_one
    type: inner
    sql_on: ${order_items.product_id} = ${products.id} ;;
  }
  join: users {
    relationship: many_to_one
    type: inner
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }
}
