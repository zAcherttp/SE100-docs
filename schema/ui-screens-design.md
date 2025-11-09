# Warehouse Management System - UI/UX Design Specification

## Design Principles

- **Mobile-First Responsive**: All screens optimized for desktop, tablet, and mobile
- **Workflow-Oriented**: Grouped by operational workflows
- **Role-Based Access**: Content adapts based on user permissions
- **Scan-Ready**: Mobile web UI supports barcode scanning via camera
- **Real-Time Updates**: Live data for sessions, inventory, and alerts

## Main Layout Structure

```html
<app-shell>
  <sidebar position="left" collapsible="true">
    <sidebar-header>
      <organization-selector dropdown="true" />
    </sidebar-header>
    
    <sidebar-content scrollable="true">
      <nav-section permission-based="true" />
    </sidebar-content>
    
    <sidebar-footer>
      <user-menu>
        <user-avatar />
        <user-name />
        <dropdown-menu>
          <item>Profile Settings</item>
          <item>Preferences</item>
          <item>Help & Support</item>
          <divider />
          <item>Logout</item>
        </dropdown-menu>
      </user-menu>
    </sidebar-footer>
  </sidebar>
  
  <main-content>
    <page-header sticky="true">
      <breadcrumbs />
      <notifications-bell badge="unread-count" />
    </page-header>
    
    <page-body>
      <!-- Screen-specific content -->
    </page-body>
  </main-content>
</app-shell>
```

---

## Navigation Structure

### Sidebar Menu (Permission-Based)

```txt

📊 Dashboard
├─ Overview (role-specific)

📥 Inbound Operations
├─ Purchase Orders
├─ Receiving (Work Sessions)
├─ Supplier Returns

📤 Outbound Operations
├─ Outbound Orders
├─ Picking Sessions
├─ Packing & Shipping

📦 Inventory Management
├─ Stock Overview
├─ Batch Tracking
├─ Serial Number Tracking
├─ Inventory Adjustments
├─ Stock Transfers

🏭 Warehouse Operations
├─ Storage Zones
├─ Zone Layout Designer
├─ Work Sessions Monitor
├─ Zone Performance

🛠️ Master Data
├─ Products & SKUs
├─ Categories
├─ Brands
├─ Suppliers

📈 Reports & Analytics
├─ Demand Forecasting
├─ Inventory Reports
├─ Performance Metrics
├─ Session Analytics

⚙️ Administration
├─ Users & Roles
├─ Branch Management
├─ Organization Settings
├─ System Lookups
├─ Audit Logs
```

---

## PART 1: DASHBOARD SCREENS

## 1. Dashboard - Warehouse Manager

**Route:** `/dashboard` or `/dashboard/manager`

**Purpose:** High-level overview with focus on oversight, approvals, and key metrics

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Dashboard</breadcrumbs>
    <date-range-selector default="today" />
    <branch-filter multi-select="true" />
    <notifications-bell />
  </page-header>
  
  <page-body layout="grid" responsive="true">
    <!-- Top KPI Cards -->
    <kpi-row cols="4" gap="md">
      <kpi-card color="blue">
        <icon>package</icon>
        <label>Total Inventory Value</label>
        <value>$1,234,567</value>
        <trend>+5.2% vs last month</trend>
      </kpi-card>
      
      <kpi-card color="green">
        <icon>trending-up</icon>
        <label>Orders Fulfilled Today</label>
        <value>142 / 150</value>
        <progress>94.7%</progress>
      </kpi-card>
      
      <kpi-card color="orange" alert="warning">
        <icon>alert-triangle</icon>
        <label>Low Stock Items</label>
        <value>23</value>
        <action>View Items</action>
      </kpi-card>
      
      <kpi-card color="purple">
        <icon>clock</icon>
        <label>Active Work Sessions</label>
        <value>8</value>
        <action>Monitor</action>
      </kpi-card>
    </kpi-row>
    
    <!-- Main Content Grid -->
    <grid-layout cols="2" cols-mobile="1">
      <!-- Pending Approvals -->
      <card span="1">
        <card-header>
          <title>Pending Approvals</title>
          <badge>5</badge>
        </card-header>
        <card-body>
          <tabs>
            <tab label="Adjustments" count="3">
              <list-item>
                <icon>edit</icon>
                <content>
                  <title>ADJ-2024-001</title>
                  <subtitle>Cycle Count Variance - Zone A</subtitle>
                  <meta>Requested by: John Doe • 2 hours ago</meta>
                </content>
                <actions>
                  <button variant="primary" size="sm">Review</button>
                </actions>
              </list-item>
              <!-- More items... -->
            </tab>
            <tab label="Returns" count="2">
              <!-- Similar structure -->
            </tab>
          </tabs>
        </card-body>
      </card>
      
      <!-- Orders Status Overview -->
      <card span="1">
        <card-header>
          <title>Order Status Overview</title>
          <dropdown>
            <option>Today</option>
            <option>This Week</option>
          </dropdown>
        </card-header>
        <card-body>
          <chart type="donut" legend="right">
            <data>
              <segment label="Completed" value="85" color="green" />
              <segment label="In Progress" value="42" color="blue" />
              <segment label="Pending" value="23" color="orange" />
              <segment label="Delayed" value="5" color="red" />
            </data>
          </chart>
        </card-body>
      </card>
      
      <!-- Inventory Health -->
      <card span="1">
        <card-header>
          <title>Inventory Health</title>
        </card-header>
        <card-body>
          <metric-list>
            <metric>
              <label>Expiring Soon (30 days)</label>
              <value color="orange">142 units</value>
              <action>View Batches</action>
            </metric>
            <metric>
              <label>Expired Items</label>
              <value color="red">8 units</value>
              <action>Take Action</action>
            </metric>
            <metric>
              <label>Overstock Items</label>
              <value color="blue">15 SKUs</value>
              <action>Review</action>
            </metric>
            <metric>
              <label>Stockout Items</label>
              <value color="red">6 SKUs</value>
              <action>Reorder</action>
            </metric>
          </metric-list>
        </card-body>
      </card>
      
      <!-- Active Work Sessions Monitor -->
      <card span="1">
        <card-header>
          <title>Active Work Sessions</title>
          <badge color="green">Live</badge>
        </card-header>
        <card-body>
          <session-list real-time="true">
            <session-item status="in-progress">
              <icon>package</icon>
              <content>
                <title>RCV-2024-034</title>
                <subtitle>Receiving - PO-2024-156</subtitle>
                <progress-bar value="65" />
                <meta>Worker: Jane Smith • Started 45m ago</meta>
              </content>
            </session-item>
            <!-- More sessions... -->
          </session-list>
          <card-footer>
            <button variant="outline" fullwidth="true">View All Sessions</button>
          </card-footer>
        </card-body>
      </card>
    </grid-layout>
    
    <!-- Performance Chart - Full Width -->
    <card span="full">
      <card-header>
        <title>Warehouse Performance Trends</title>
        <button-group>
          <button active="true">7 Days</button>
          <button>30 Days</button>
          <button>90 Days</button>
        </button-group>
      </card-header>
      <card-body>
        <chart type="multi-line" height="300px">
          <x-axis label="Date" />
          <y-axis label="Orders" />
          <line label="Orders Received" color="blue" />
          <line label="Orders Fulfilled" color="green" />
          <line label="Accuracy Rate %" color="purple" />
        </chart>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 2. Dashboard - Warehouse Worker

**Route:** `/dashboard/worker`

**Purpose:** Task-focused view with quick access to assigned work sessions

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>My Dashboard</breadcrumbs>
    <branch-display current="true" />
    <notifications-bell />
  </page-header>
  
  <page-body layout="stack" gap="lg">
    <!-- Quick Stats -->
    <stats-bar layout="horizontal" mobile-scroll="true">
      <stat-item>
        <label>My Tasks Today</label>
        <value>8</value>
      </stat-item>
      <stat-item>
        <label>Completed</label>
        <value color="green">5</value>
      </stat-item>
      <stat-item>
        <label>In Progress</label>
        <value color="blue">1</value>
      </stat-item>
      <stat-item>
        <label>Pending</label>
        <value>2</value>
      </stat-item>
      <stat-item>
        <label>My Accuracy</label>
        <value color="purple">98.5%</value>
      </stat-item>
    </stats-bar>
    
    <!-- Current Active Session (if any) -->
    <card highlight="true" border-color="blue" size="lg" conditional="has-active-session">
      <card-header>
        <title>Current Session</title>
        <badge color="green" pulse="true">Active</badge>
      </card-header>
      <card-body>
        <session-details>
          <detail-row>
            <label>Session Code</label>
            <value monospace="true">RCV-2024-034</value>
          </detail-row>
          <detail-row>
            <label>Type</label>
            <value>
              <badge color="blue">Receiving</badge>
            </value>
          </detail-row>
          <detail-row>
            <label>Related Order</label>
            <value>PO-2024-156 - ABC Suppliers</value>
          </detail-row>
          <detail-row>
            <label>Progress</label>
            <value>
              <progress-bar value="65" show-label="true">22 / 34 items</progress-bar>
            </value>
          </detail-row>
          <detail-row>
            <label>Duration</label>
            <value>
              <timer live="true">00:45:32</timer>
            </value>
          </detail-row>
        </session-details>
        
        <button-group layout="horizontal" margin-top="md">
          <button variant="primary" size="lg" fullwidth="true">
            <icon>play</icon>
            Continue Session
          </button>
          <button variant="outline" size="lg">
            <icon>pause</icon>
            Pause
          </button>
        </button-group>
      </card-body>
    </card>
    
    <!-- Assigned Tasks -->
    <card>
      <card-header>
        <title>My Assigned Tasks</title>
        <filter-chips>
          <chip active="true">All (8)</chip>
          <chip>Receiving (3)</chip>
          <chip>Picking (4)</chip>
          <chip>Packing (1)</chip>
        </filter-chips>
      </card-header>
      <card-body>
        <task-list>
          <task-item priority="high">
            <task-icon type="receiving" color="red" />
            <task-content>
              <task-title>Receive Purchase Order</task-title>
              <task-code>PO-2024-157</task-code>
              <task-meta>
                <meta-item>
                  <icon>package</icon>
                  <text>35 items</text>
                </meta-item>
                <meta-item>
                  <icon>truck</icon>
                  <text>XYZ Suppliers</text>
                </meta-item>
                <meta-item>
                  <icon>clock</icon>
                  <text>Expected: Today 2:00 PM</text>
                </meta-item>
              </task-meta>
            </task-content>
            <task-actions>
              <button variant="primary" size="sm">Start</button>
            </task-actions>
          </task-item>
          
          <task-item priority="medium">
            <task-icon type="picking" color="blue" />
            <task-content>
              <task-title>Pick Outbound Order</task-title>
              <task-code>OUT-2024-089</task-code>
              <task-meta>
                <meta-item>
                  <icon>package</icon>
                  <text>12 items</text>
                </meta-item>
                <meta-item>
                  <icon>map-pin</icon>
                  <text>4 zones</text>
                </meta-item>
                <meta-item>
                  <icon>clock</icon>
                  <text>Due: Today 4:00 PM</text>
                </meta-item>
              </task-meta>
            </task-content>
            <task-actions>
              <button variant="primary" size="sm">Start</button>
            </task-actions>
          </task-item>
          
          <!-- More task items... -->
        </task-list>
      </card-body>
    </card>
    
    <!-- Quick Actions -->
    <card>
      <card-header>
        <title>Quick Actions</title>
      </card-header>
      <card-body>
        <action-grid cols="2" cols-mobile="2">
          <action-button>
            <icon>scan</icon>
            <label>Quick Scan</label>
          </action-button>
          <action-button>
            <icon>search</icon>
            <label>Find SKU</label>
          </action-button>
          <action-button>
            <icon>map-pin</icon>
            <label>Find Zone</label>
          </action-button>
          <action-button>
            <icon>package</icon>
            <label>Check Inventory</label>
          </action-button>
        </action-grid>
      </card-body>
    </card>
    
    <!-- Recent Activity -->
    <card>
      <card-header>
        <title>My Recent Sessions</title>
      </card-header>
      <card-body>
        <timeline>
          <timeline-item status="completed">
            <icon color="green">check-circle</icon>
            <content>
              <title>Completed Receiving Session</title>
              <subtitle>RCV-2024-033 • PO-2024-155</subtitle>
              <meta>Today at 10:30 AM • Duration: 42 min • Accuracy: 100%</meta>
            </content>
          </timeline-item>
          <timeline-item status="completed">
            <icon color="green">check-circle</icon>
            <content>
              <title>Completed Picking Session</title>
              <subtitle>PICK-2024-078 • OUT-2024-087</subtitle>
              <meta>Today at 9:15 AM • Duration: 28 min • Accuracy: 97.5%</meta>
            </content>
          </timeline-item>
        </timeline>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 3. Dashboard - Inventory Controller

**Route:** `/dashboard/controller`

**Purpose:** Inventory health monitoring and adjustment management

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Dashboard</breadcrumbs>
    <date-selector />
    <branch-filter />
    <notifications-bell />
  </page-header>
  
  <page-body layout="grid" responsive="true">
    <!-- Inventory KPIs -->
    <kpi-row cols="4" gap="md">
      <kpi-card color="teal">
        <icon>layers</icon>
        <label>Total SKUs</label>
        <value>1,847</value>
        <sublabel>Active inventory items</sublabel>
      </kpi-card>
      
      <kpi-card color="blue">
        <icon>package</icon>
        <label>Total Units</label>
        <value>45,382</value>
        <trend>+2.1% vs last week</trend>
      </kpi-card>
      
      <kpi-card color="orange" alert="warning">
        <icon>alert-circle</icon>
        <label>Pending Adjustments</label>
        <value>12</value>
        <action>Review</action>
      </kpi-card>
      
      <kpi-card color="purple">
        <icon>activity</icon>
        <label>Turnover Rate</label>
        <value>4.2x</value>
        <sublabel>Last 30 days</sublabel>
      </kpi-card>
    </kpi-row>
    
    <!-- Alerts & Actions Required -->
    <card span="full">
      <card-header>
        <title>Alerts & Actions Required</title>
        <badge color="red">8</badge>
      </card-header>
      <card-body>
        <alert-list>
          <alert-item severity="high">
            <icon>alert-triangle</icon>
            <content>
              <title>6 SKUs Below Reorder Point</title>
              <description>Immediate action required to prevent stockouts</description>
            </content>
            <actions>
              <button variant="primary" size="sm">Create Purchase Order</button>
              <button variant="ghost" size="sm">View Items</button>
            </actions>
          </alert-item>
          
          <alert-item severity="medium">
            <icon>clock</icon>
            <content>
              <title>142 Units Expiring in 30 Days</title>
              <description>Review batches and plan outbound priority</description>
            </content>
            <actions>
              <button variant="primary" size="sm">View Batches</button>
            </actions>
          </alert-item>
          
          <alert-item severity="high">
            <icon>x-circle</icon>
            <content>
              <title>8 Units Already Expired</title>
              <description>Quarantine and process for disposal or return</description>
            </content>
            <actions>
              <button variant="danger" size="sm">Process Now</button>
            </actions>
          </alert-item>
        </alert-list>
      </card-body>
    </card>
    
    <!-- Inventory Status Grid -->
    <grid-layout cols="2" cols-mobile="1">
      <card>
        <card-header>
          <title>Stock Status Distribution</title>
        </card-header>
        <card-body>
          <chart type="bar" orientation="horizontal">
            <bar label="Optimal Stock" value="1245" color="green" />
            <bar label="Low Stock" value="342" color="orange" />
            <bar label="Out of Stock" value="23" color="red" />
            <bar label="Overstock" value="127" color="blue" />
            <bar label="Quarantine" value="8" color="gray" />
          </chart>
        </card-body>
      </card>
      
      <card>
        <card-header>
          <title>Batch Expiry Timeline</title>
        </card-header>
        <card-body>
          <chart type="area" stacked="true">
            <x-axis label="Weeks" />
            <y-axis label="Units" />
            <area label="Expired" color="red" />
            <area label="< 1 week" color="orange" />
            <area label="1-4 weeks" color="yellow" />
            <area label="1-3 months" color="blue" />
            <area label="> 3 months" color="green" />
          </chart>
        </card-body>
      </card>
    </grid-layout>
    
    <!-- Pending Adjustment Requests -->
    <card span="full">
      <card-header>
        <title>Pending Adjustment Requests</title>
        <button variant="primary">
          <icon>plus</icon>
          New Adjustment
        </button>
      </card-header>
      <card-body>
        <data-table responsive="true">
          <table-header>
            <column sortable="true">Request Code</column>
            <column sortable="true">Type</column>
            <column>SKU / Batch</column>
            <column sortable="true">Variance</column>
            <column sortable="true">Cost Impact</column>
            <column sortable="true">Requested By</column>
            <column sortable="true">Date</column>
            <column>Status</column>
            <column>Actions</column>
          </table-header>
          <table-body>
            <row>
              <cell>
                <link>ADJ-2024-001</link>
              </cell>
              <cell>Cycle Count</cell>
              <cell>
                <stack>
                  <text>SKU-1234-A</text>
                  <text small="true" muted="true">Batch: B-2024-089</text>
                </stack>
              </cell>
              <cell>
                <badge color="red">-15 units</badge>
              </cell>
              <cell color="red">-$375.00</cell>
              <cell>John Doe</cell>
              <cell>Nov 9, 10:30 AM</cell>
              <cell>
                <badge color="orange">Pending Review</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="primary">Review</button>
                  <button size="sm" variant="outline">Details</button>
                </button-group>
              </cell>
            </row>
            <!-- More rows... -->
          </table-body>
        </data-table>
      </card-body>
    </card>
    
    <!-- Top Moving Items -->
    <grid-layout cols="2" cols-mobile="1">
      <card>
        <card-header>
          <title>Fastest Moving Items</title>
          <subtitle>Last 30 days</subtitle>
        </card-header>
        <card-body>
          <ranked-list>
            <list-item rank="1">
              <content>
                <title>Product Name ABC</title>
                <subtitle>SKU-5678-B</subtitle>
              </content>
              <metric>
                <value>1,247</value>
                <label>units</label>
              </metric>
            </list-item>
            <!-- More items... -->
          </ranked-list>
        </card-body>
      </card>
      
      <card>
        <card-header>
          <title>Slowest Moving Items</title>
          <subtitle>Last 30 days</subtitle>
        </card-header>
        <card-body>
          <ranked-list>
            <list-item rank="1">
              <content>
                <title>Product Name XYZ</title>
                <subtitle>SKU-9012-C</subtitle>
              </content>
              <metric>
                <value>3</value>
                <label>units</label>
              </metric>
            </list-item>
            <!-- More items... -->
          </ranked-list>
        </card-body>
      </card>
    </grid-layout>
  </page-body>
</screen>
```

---

## 4. Dashboard - Administrator

**Route:** `/dashboard/admin`

**Purpose:** System health, user activity, and configuration oversight

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Admin Dashboard</breadcrumbs>
    <organization-selector />
    <notifications-bell />
  </page-header>
  
  <page-body layout="grid" responsive="true">
    <!-- System Health KPIs -->
    <kpi-row cols="4" gap="md">
      <kpi-card color="green">
        <icon>users</icon>
        <label>Active Users</label>
        <value>45 / 52</value>
        <sublabel>Currently online: 12</sublabel>
      </kpi-card>
      
      <kpi-card color="blue">
        <icon>building</icon>
        <label>Active Branches</label>
        <value>8</value>
        <sublabel>All operational</sublabel>
      </kpi-card>
      
      <kpi-card color="purple">
        <icon>activity</icon>
        <label>System Load</label>
        <value>Normal</value>
        <progress-bar value="45" color="green" />
      </kpi-card>
      
      <kpi-card color="orange">
        <icon>bell</icon>
        <label>System Alerts</label>
        <value>3</value>
        <action>View</action>
      </kpi-card>
    </kpi-row>
    
    <!-- Quick Admin Actions -->
    <card span="full">
      <card-header>
        <title>Quick Actions</title>
      </card-header>
      <card-body>
        <action-grid cols="6" cols-tablet="3" cols-mobile="2">
          <action-card>
            <icon size="lg">user-plus</icon>
            <label>Add User</label>
          </action-card>
          <action-card>
            <icon size="lg">building</icon>
            <label>Add Branch</label>
          </action-card>
          <action-card>
            <icon size="lg">shield</icon>
            <label>Manage Roles</label>
          </action-card>
          <action-card>
            <icon size="lg">package</icon>
            <label>Add Product</label>
          </action-card>
          <action-card>
            <icon size="lg">settings</icon>
            <label>System Settings</label>
          </action-card>
          <action-card>
            <icon size="lg">database</icon>
            <label>Backup Data</label>
          </action-card>
        </action-grid>
      </card-body>
    </card>
    
    <!-- Recent Activity & Audit -->
    <grid-layout cols="2" cols-mobile="1">
      <card>
        <card-header>
          <title>Recent User Activity</title>
          <badge color="green" pulse="true">Live</badge>
        </card-header>
        <card-body>
          <activity-feed real-time="true">
            <activity-item>
              <avatar>JD</avatar>
              <content>
                <text><strong>John Doe</strong> completed receiving session <link>RCV-2024-034</link></text>
                <time>2 minutes ago</time>
              </content>
            </activity-item>
            <activity-item>
              <avatar>SM</avatar>
              <content>
                <text><strong>Sarah Miller</strong> created adjustment request <link>ADJ-2024-001</link></text>
                <time>15 minutes ago</time>
              </content>
            </activity-item>
            <activity-item>
              <avatar>BJ</avatar>
              <content>
                <text><strong>Bob Johnson</strong> approved purchase order <link>PO-2024-157</link></text>
                <time>1 hour ago</time>
              </content>
            </activity-item>
          </activity-feed>
        </card-body>
        <card-footer>
          <link>View All Activity</link>
        </card-footer>
      </card>
      
      <card>
        <card-header>
          <title>System Alerts & Notifications</title>
        </card-header>
        <card-body>
          <alert-list>
            <alert-item severity="low">
              <icon>info</icon>
              <content>
                <title>Database backup completed</title>
                <time>30 minutes ago</time>
              </content>
            </alert-item>
            <alert-item severity="medium">
              <icon>alert-circle</icon>
              <content>
                <title>5 users pending activation</title>
                <time>2 hours ago</time>
              </content>
              <actions>
                <button size="sm">Review</button>
              </actions>
            </alert-item>
            <alert-item severity="low">
              <icon>check</icon>
              <content>
                <title>System update available</title>
                <time>1 day ago</time>
              </content>
              <actions>
                <button size="sm">View Details</button>
              </actions>
            </alert-item>
          </alert-list>
        </card-body>
      </card>
    </grid-layout>
    
    <!-- Usage Analytics -->
    <card span="full">
      <card-header>
        <title>Usage Analytics</title>
        <button-group>
          <button active="true">7 Days</button>
          <button>30 Days</button>
          <button>90 Days</button>
        </button-group>
      </card-header>
      <card-body>
        <chart type="combo">
          <x-axis label="Date" />
          <y-axis label="Count" position="left" />
          <y-axis label="Users" position="right" />
          <bar label="Sessions" color="blue" />
          <bar label="Orders Processed" color="green" />
          <line label="Active Users" color="purple" axis="right" />
        </chart>
      </card-body>
    </card>
    
    <!-- Branch Performance Summary -->
    <card span="full">
      <card-header>
        <title>Branch Performance Summary</title>
      </card-header>
      <card-body>
        <data-table>
          <table-header>
            <column sortable="true">Branch</column>
            <column sortable="true">Active Users</column>
            <column sortable="true">Orders Today</column>
            <column sortable="true">Accuracy %</column>
            <column sortable="true">Inventory Value</column>
            <column>Status</column>
          </table-header>
          <table-body>
            <row>
              <cell>
                <stack>
                  <text strong="true">Main Warehouse</text>
                  <text small="true" muted="true">New York, NY</text>
                </stack>
              </cell>
              <cell>18</cell>
              <cell>245</cell>
              <cell>
                <badge color="green">98.2%</badge>
              </cell>
              <cell>$2,456,789</cell>
              <cell>
                <badge color="green">Operational</badge>
              </cell>
            </row>
            <!-- More rows... -->
          </table-body>
        </data-table>
      </card-body>
    </card>
    
    <!-- Pending Workspace Invitations -->
    <card>
      <card-header>
        <title>Pending Invitations</title>
        <button variant="primary" size="sm">
          <icon>mail</icon>
          Send Invitation
        </button>
      </card-header>
      <card-body>
        <list>
          <list-item>
            <content>
              <title>jane.smith@example.com</title>
              <subtitle>Code: INV-ABC123 • Expires in 5 days</subtitle>
            </content>
            <actions>
              <button size="sm" variant="ghost">Resend</button>
              <button size="sm" variant="ghost" color="red">Revoke</button>
            </actions>
          </list-item>
        </list>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

This completes **Part 1: Dashboard Screens** for all four user roles.

Each dashboard is optimized for:

- ✅ **Role-specific priorities** (Manager: oversight, Worker: tasks, Controller: inventory health, Admin: system)
- ✅ **Mobile-responsive** with collapsible grids and scrollable components
- ✅ **Real-time updates** for live sessions and activities
- ✅ **Quick actions** for common workflows
- ✅ **Visual hierarchy** with cards, KPIs, and charts

---

## PART 2: INBOUND OPERATIONS

## 5. Purchase Orders - List View

**Route:** `/inbound/purchase-orders`

**Purpose:** View and manage all purchase orders

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Inbound → Purchase Orders</breadcrumbs>
    <button variant="primary">
      <icon>plus</icon>
      New Purchase Order
    </button>
  </page-header>
  
  <page-body>
    <!-- Filter Bar -->
    <filter-bar sticky="true">
      <search-input placeholder="Search by PO code, supplier..." />
      <filter-group>
        <filter-select label="Status">
          <option value="all">All Statuses</option>
          <option value="draft">Draft</option>
          <option value="submitted">Submitted</option>
          <option value="confirmed">Confirmed</option>
          <option value="partial">Partially Received</option>
          <option value="received">Fully Received</option>
          <option value="cancelled">Cancelled</option>
        </filter-select>
        
        <filter-select label="Branch">
          <option value="all">All Branches</option>
          <!-- Branch options -->
        </filter-select>
        
        <filter-select label="Supplier">
          <option value="all">All Suppliers</option>
          <!-- Supplier options -->
        </filter-select>
        
        <date-range-picker label="Expected Delivery" />
      </filter-group>
      
      <button-group>
        <button variant="ghost">
          <icon>filter</icon>
          More Filters
        </button>
        <button variant="ghost">
          <icon>download</icon>
          Export
        </button>
      </button-group>
    </filter-bar>
    
    <!-- Summary Stats -->
    <stats-bar>
      <stat-chip>
        <label>Total Orders</label>
        <value>247</value>
      </stat-chip>
      <stat-chip color="orange">
        <label>Pending</label>
        <value>34</value>
      </stat-chip>
      <stat-chip color="blue">
        <label>In Transit</label>
        <value>18</value>
      </stat-chip>
      <stat-chip color="green">
        <label>This Month</label>
        <value>89</value>
      </stat-chip>
    </stats-bar>
    
    <!-- Data Table -->
    <card>
      <card-body padding="none">
        <data-table responsive="card" selection="multiple">
          <table-header>
            <column width="40px">
              <checkbox />
            </column>
            <column sortable="true" width="140px">PO Code</column>
            <column sortable="true">Supplier</column>
            <column sortable="true">Branch</column>
            <column sortable="true" align="right">Total Items</column>
            <column sortable="true" align="right">Total Cost</column>
            <column sortable="true">Ordered Date</column>
            <column sortable="true">Expected Delivery</column>
            <column sortable="true">Status</column>
            <column width="120px">Actions</column>
          </table-header>
          
          <table-body>
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">PO-2024-157</link>
              </cell>
              <cell>
                <stack>
                  <text>ABC Suppliers Inc.</text>
                  <text small="true" muted="true">Contact: John Smith</text>
                </stack>
              </cell>
              <cell>Main Warehouse</cell>
              <cell align="right">35</cell>
              <cell align="right">$12,450.00</cell>
              <cell>Nov 5, 2024</cell>
              <cell>
                <stack>
                  <text>Nov 9, 2024 2:00 PM</text>
                  <badge size="sm" color="orange">Due Today</badge>
                </stack>
              </cell>
              <cell>
                <badge color="blue">Confirmed</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost" title="View">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="ghost" title="Start Receiving">
                    <icon>package</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>
                      <icon>edit</icon>
                      Edit
                    </menu-item>
                    <menu-item>
                      <icon>copy</icon>
                      Duplicate
                    </menu-item>
                    <menu-item>
                      <icon>printer</icon>
                      Print
                    </menu-item>
                    <divider />
                    <menu-item color="danger">
                      <icon>x</icon>
                      Cancel Order
                    </menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">PO-2024-156</link>
              </cell>
              <cell>
                <stack>
                  <text>XYZ Distribution</text>
                  <text small="true" muted="true">Contact: Sarah Miller</text>
                </stack>
              </cell>
              <cell>East Warehouse</cell>
              <cell align="right">42</cell>
              <cell align="right">$8,920.00</cell>
              <cell>Nov 3, 2024</cell>
              <cell>
                <stack>
                  <text>Nov 8, 2024 10:00 AM</text>
                  <badge size="sm" color="red">Overdue</badge>
                </stack>
              </cell>
              <cell>
                <badge color="orange">Partial (18/42)</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost" title="View">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="primary" title="Continue Receiving">
                    <icon>play</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>Edit</menu-item>
                    <menu-item>Print</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
        </data-table>
        
        <!-- Pagination -->
        <table-footer>
          <pagination>
            <page-info>Showing 1-20 of 247</page-info>
            <page-controls>
              <button disabled="true">Previous</button>
              <button active="true">1</button>
              <button>2</button>
              <button>3</button>
              <span>...</span>
              <button>13</button>
              <button>Next</button>
            </page-controls>
            <page-size-selector>
              <option>20 per page</option>
              <option>50 per page</option>
              <option>100 per page</option>
            </page-size-selector>
          </pagination>
        </table-footer>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 6. Purchase Order - Detail View

**Route:** `/inbound/purchase-orders/:id`

**Purpose:** View complete PO details and manage receiving process

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>
      <link>Inbound</link> → <link>Purchase Orders</link> → PO-2024-157
    </breadcrumbs>
    <button-group>
      <button variant="outline">
        <icon>edit</icon>
        Edit
      </button>
      <button variant="outline">
        <icon>printer</icon>
        Print
      </button>
      <button variant="primary">
        <icon>package</icon>
        Start Receiving
      </button>
      <dropdown-menu>
        <menu-item>
          <icon>copy</icon>
          Duplicate
        </menu-item>
        <menu-item>
          <icon>mail</icon>
          Email to Supplier
        </menu-item>
        <menu-item>
          <icon>download</icon>
          Export PDF
        </menu-item>
        <divider />
        <menu-item color="danger">
          <icon>x</icon>
          Cancel Order
        </menu-item>
      </dropdown-menu>
    </button-group>
  </page-header>
  
  <page-body layout="grid" gap="lg">
    <!-- Status Banner -->
    <alert-banner color="blue" span="full" dismissible="false">
      <icon>info</icon>
      <content>
        <strong>Expected Delivery Today:</strong> This order is scheduled for delivery at 2:00 PM
      </content>
      <action>
        <button variant="primary" size="sm">Start Receiving Session</button>
      </action>
    </alert-banner>
    
    <!-- Main Info Card -->
    <card span="2">
      <card-header>
        <title-group>
          <title>Purchase Order PO-2024-157</title>
          <badge color="blue" size="lg">Confirmed</badge>
        </title-group>
      </card-header>
      
      <card-body>
        <details-grid cols="3" cols-mobile="1">
          <detail-item>
            <label>Supplier</label>
            <value>
              <link>ABC Suppliers Inc.</link>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Branch</label>
            <value>Main Warehouse</value>
          </detail-item>
          
          <detail-item>
            <label>Created By</label>
            <value>John Manager</value>
          </detail-item>
          
          <detail-item>
            <label>Order Date</label>
            <value>Nov 5, 2024 10:30 AM</value>
          </detail-item>
          
          <detail-item>
            <label>Expected Delivery</label>
            <value>
              <stack>
                <text>Nov 9, 2024 2:00 PM</text>
                <badge size="sm" color="orange">Due Today</badge>
              </stack>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Lead Time</label>
            <value>4 days</value>
          </detail-item>
          
          <detail-item>
            <label>Total Items</label>
            <value strong="true">35 items</value>
          </detail-item>
          
          <detail-item>
            <label>Received Items</label>
            <value>
              <progress-indicator>
                <value>0 / 35</value>
                <progress-bar value="0" />
              </progress-indicator>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Total Cost</label>
            <value strong="true" size="lg">$12,450.00</value>
          </detail-item>
        </details-grid>
      </card-body>
    </card>
    
    <!-- Supplier Contact Info -->
    <card span="1">
      <card-header>
        <title>Supplier Contact</title>
      </card-header>
      <card-body>
        <contact-info>
          <info-item>
            <icon>user</icon>
            <label>Contact Person</label>
            <value>John Smith</value>
          </info-item>
          <info-item>
            <icon>mail</icon>
            <label>Email</label>
            <value>
              <link>john.smith@abcsuppliers.com</link>
            </value>
          </info-item>
          <info-item>
            <icon>phone</icon>
            <label>Phone</label>
            <value>
              <link>+1 (555) 123-4567</link>
            </value>
          </info-item>
        </contact-info>
      </card-body>
    </card>
    
    <!-- Order Items -->
    <card span="full">
      <card-header>
        <title>Order Items</title>
        <search-input size="sm" placeholder="Search items..." />
      </card-header>
      
      <card-body padding="none">
        <data-table responsive="card">
          <table-header>
            <column width="60px">#</column>
            <column>SKU Code</column>
            <column>Product Description</column>
            <column align="right">Qty Ordered</column>
            <column align="right">Qty Received</column>
            <column align="right">Unit Cost</column>
            <column align="right">Total Cost</column>
            <column>Status</column>
          </table-header>
          
          <table-body>
            <row>
              <cell>1</cell>
              <cell>
                <link monospace="true">SKU-1234-A</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Premium Widget Pro</text>
                  <text small="true" muted="true">Category: Electronics • Brand: TechCorp</text>
                </stack>
              </cell>
              <cell align="right">50</cell>
              <cell align="right">
                <badge color="gray">0</badge>
              </cell>
              <cell align="right">$125.00</cell>
              <cell align="right" strong="true">$6,250.00</cell>
              <cell>
                <badge color="orange">Pending</badge>
              </cell>
            </row>
            
            <row>
              <cell>2</cell>
              <cell>
                <link monospace="true">SKU-5678-B</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Standard Gadget Plus</text>
                  <text small="true" muted="true">Category: Hardware • Brand: BuildCo</text>
                </stack>
              </cell>
              <cell align="right">100</cell>
              <cell align="right">
                <badge color="gray">0</badge>
              </cell>
              <cell align="right">$45.50</cell>
              <cell align="right" strong="true">$4,550.00</cell>
              <cell>
                <badge color="orange">Pending</badge>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
          
          <table-footer>
            <summary-row>
              <cell colspan="6" align="right" strong="true">Subtotal:</cell>
              <cell align="right" strong="true">$11,800.00</cell>
              <cell></cell>
            </summary-row>
            <summary-row>
              <cell colspan="6" align="right">Tax (5.5%):</cell>
              <cell align="right">$649.00</cell>
              <cell></cell>
            </summary-row>
            <summary-row>
              <cell colspan="6" align="right">Shipping:</cell>
              <cell align="right">$1.00</cell>
              <cell></cell>
            </summary-row>
            <summary-row highlight="true">
              <cell colspan="6" align="right" strong="true" size="lg">Total:</cell>
              <cell align="right" strong="true" size="lg">$12,450.00</cell>
              <cell></cell>
            </summary-row>
          </table-footer>
        </data-table>
      </card-body>
    </card>
    
    <!-- Activity Timeline -->
    <card span="full">
      <card-header>
        <title>Order History</title>
      </card-header>
      <card-body>
        <timeline>
          <timeline-item status="completed">
            <icon color="green">check-circle</icon>
            <content>
              <title>Order Confirmed by Supplier</title>
              <meta>Nov 5, 2024 3:45 PM • Confirmed by: John Smith (ABC Suppliers)</meta>
            </content>
          </timeline-item>
          
          <timeline-item status="completed">
            <icon color="blue">send</icon>
            <content>
              <title>Order Submitted to Supplier</title>
              <meta>Nov 5, 2024 2:30 PM • Sent via email</meta>
            </content>
          </timeline-item>
          
          <timeline-item status="completed">
            <icon color="blue">file-text</icon>
            <content>
              <title>Purchase Order Created</title>
              <meta>Nov 5, 2024 10:30 AM • Created by: John Manager</meta>
              <details>
                <text small="true">Initial order with 35 line items totaling $12,450.00</text>
              </details>
            </content>
          </timeline-item>
        </timeline>
      </card-body>
    </card>
    
    <!-- Attachments -->
    <card span="1">
      <card-header>
        <title>Attachments</title>
        <button size="sm" variant="ghost">
          <icon>upload</icon>
          Upload
        </button>
      </card-header>
      <card-body>
        <file-list>
          <file-item>
            <file-icon type="pdf" />
            <file-info>
              <file-name>PO-2024-157.pdf</file-name>
              <file-meta>245 KB • Nov 5, 2024</file-meta>
            </file-info>
            <file-actions>
              <button size="sm" variant="ghost">
                <icon>download</icon>
              </button>
            </file-actions>
          </file-item>
        </file-list>
      </card-body>
    </card>
    
    <!-- Notes -->
    <card span="2">
      <card-header>
        <title>Notes & Comments</title>
      </card-header>
      <card-body>
        <comment-thread>
          <comment>
            <avatar>JM</avatar>
            <content>
              <author>John Manager</author>
              <time>Nov 5, 2024 10:35 AM</time>
              <text>Confirmed delivery window with supplier. Please ensure receiving team is ready at 2 PM.</text>
            </content>
          </comment>
        </comment-thread>
        
        <comment-input>
          <textarea placeholder="Add a note..." />
          <button variant="primary" size="sm">Add Comment</button>
        </comment-input>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 7. Receiving Work Session - Mobile Optimized

**Route:** `/inbound/receiving/:sessionId`

**Purpose:** Mobile-optimized interface for scanning and receiving items

**Layout:**

```html
<screen mode="fullscreen" optimize="mobile">
  <!-- Minimal header for mobile -->
  <session-header fixed="true">
    <back-button />
    <session-info>
      <session-code monospace="true">RCV-2024-034</session-code>
      <session-timer live="true">00:24:15</session-timer>
    </session-info>
    <menu-button>
      <dropdown-menu position="bottom-right">
        <menu-item>
          <icon>pause</icon>
          Pause Session
        </menu-item>
        <menu-item>
          <icon>help-circle</icon>
          Help
        </menu-item>
        <divider />
        <menu-item color="danger">
          <icon>x</icon>
          Cancel Session
        </menu-item>
      </dropdown-menu>
    </menu-button>
  </session-header>
  
  <page-body padding="sm">
    <!-- Progress Card -->
    <card>
      <card-body>
        <progress-summary>
          <progress-bar value="63" size="lg" animated="true">
            <label>22 of 35 items received</label>
          </progress-bar>
          
          <stats-row>
            <stat>
              <value color="green">22</value>
              <label>Scanned</label>
            </stat>
            <stat>
              <value color="orange">13</value>
              <label>Remaining</label>
            </stat>
            <stat>
              <value color="blue">PO-2024-157</value>
              <label>Order</label>
            </stat>
          </stats-row>
        </progress-summary>
      </card-body>
    </card>
    
    <!-- Scanner Interface -->
    <card highlight="true">
      <card-header>
        <title>Scan Items</title>
        <badge color="green" pulse="true">Ready</badge>
      </card-header>
      
      <card-body>
        <!-- Camera Scanner -->
        <scanner-component>
          <camera-view height="200px" radius="md">
            <scan-overlay>
              <scan-guide />
              <scan-instructions>Point camera at barcode</scan-instructions>
            </scan-overlay>
          </camera-view>
          
          <scanner-controls>
            <button variant="primary" size="lg" fullwidth="true">
              <icon>camera</icon>
              Open Camera Scanner
            </button>
            
            <text-divider>or</text-divider>
            
            <input-group>
              <input 
                type="text" 
                placeholder="Enter SKU or Barcode manually" 
                size="lg"
                autofocus="true"
              />
              <button variant="outline">
                <icon>arrow-right</icon>
              </button>
            </input-group>
          </scanner-controls>
        </scanner-component>
        
        <!-- Last Scanned Item Feedback -->
        <feedback-card color="success" show="after-scan" animate="slide-down">
          <icon size="lg">check-circle</icon>
          <content>
            <title>Item Scanned Successfully!</title>
            <subtitle>SKU-1234-A • Premium Widget Pro</subtitle>
          </content>
        </feedback-card>
      </card-body>
    </card>
    
    <!-- Current Item Details (after scan) -->
    <card conditional="item-scanned">
      <card-header>
        <title>Scanned Item</title>
      </card-header>
      
      <card-body>
        <item-details>
          <detail-row>
            <label>SKU Code</label>
            <value monospace="true" strong="true">SKU-1234-A</value>
          </detail-row>
          
          <detail-row>
            <label>Product</label>
            <value>Premium Widget Pro</value>
          </detail-row>
          
          <detail-row>
            <label>Expected Quantity</label>
            <value>50 units</value>
          </detail-row>
          
          <detail-row>
            <label>Already Received</label>
            <value>25 units</value>
          </detail-row>
          
          <detail-row>
            <label>Remaining</label>
            <value color="orange" strong="true">25 units</value>
          </detail-row>
        </item-details>
        
        <!-- Quantity Input -->
        <form-section>
          <form-label>Receiving Quantity</form-label>
          <quantity-input size="lg">
            <button type="button" variant="outline">
              <icon>minus</icon>
            </button>
            <input 
              type="number" 
              value="25" 
              min="1" 
              max="25"
              size="lg"
              text-align="center"
            />
            <button type="button" variant="outline">
              <icon>plus</icon>
            </button>
          </quantity-input>
          
          <helper-text>Maximum: 25 units remaining</helper-text>
        </form-section>
        
        <!-- Batch Information -->
        <form-section>
          <form-label required="true">Storage Zone</form-label>
          <select size="lg">
            <option>Select zone...</option>
            <option>Zone A - Row 1 - Shelf 3</option>
            <option>Zone A - Row 2 - Shelf 1</option>
            <option>Zone B - Row 1 - Shelf 2</option>
          </select>
        </form-section>
        
        <form-section>
          <form-label>Supplier Batch Number</form-label>
          <input type="text" placeholder="Enter batch number (optional)" size="lg" />
        </form-section>
        
        <form-section>
          <form-label>Manufacturing Date</form-label>
          <input type="date" size="lg" />
        </form-section>
        
        <form-section>
          <form-label>Expiry Date</form-label>
          <input type="date" size="lg" />
        </form-section>
        
        <form-section>
          <form-label>Notes (Optional)</form-label>
          <textarea rows="2" placeholder="Any comments or issues..."></textarea>
        </form-section>
        
        <!-- Action Buttons -->
        <button-group layout="stack" gap="sm">
          <button variant="primary" size="lg" fullwidth="true">
            <icon>check</icon>
            Confirm & Continue
          </button>
          <button variant="outline" size="lg" fullwidth="true">
            <icon>alert-triangle</icon>
            Report Issue
          </button>
        </button-group>
      </card-body>
    </card>
    
    <!-- Received Items List -->
    <card>
      <card-header>
        <title>Received Items</title>
        <badge>22</badge>
      </card-header>
      
      <card-body padding="none">
        <list scrollable="true" max-height="300px">
          <list-item>
            <item-icon color="green">
              <icon>check</icon>
            </item-icon>
            <item-content>
              <item-title>SKU-1234-A</item-title>
              <item-subtitle>Premium Widget Pro</item-subtitle>
              <item-meta>Qty: 25 • Zone: A-R1-S3 • 2:34 PM</item-meta>
            </item-content>
            <item-actions>
              <button size="sm" variant="ghost">
                <icon>edit</icon>
              </button>
            </item-actions>
          </list-item>
          
          <list-item>
            <item-icon color="green">
              <icon>check</icon>
            </item-icon>
            <item-content>
              <item-title>SKU-5678-B</item-title>
              <item-subtitle>Standard Gadget Plus</item-subtitle>
              <item-meta>Qty: 50 • Zone: B-R2-S1 • 2:28 PM</item-meta>
            </item-content>
            <item-actions>
              <button size="sm" variant="ghost">
                <icon>edit</icon>
              </button>
            </item-actions>
          </list-item>
          
          <!-- More items... -->
        </list>
      </card-body>
    </card>
    
    <!-- Remaining Items -->
    <card>
      <card-header>
        <title>Remaining Items</title>
        <badge color="orange">13</badge>
      </card-header>
      
      <card-body padding="none">
        <list>
          <list-item>
            <item-icon color="gray">
              <icon>package</icon>
            </item-icon>
            <item-content>
              <item-title>SKU-9012-C</item-title>
              <item-subtitle>Deluxe Tool Set</item-subtitle>
              <item-meta>Expected: 15 units</item-meta>
            </item-content>
          </list-item>
          
          <!-- More items... -->
        </list>
      </card-body>
    </card>
  </page-body>
  
  <!-- Fixed Bottom Action Bar -->
  <bottom-action-bar fixed="true" safe-area="true">
    <button variant="outline" size="lg">
      <icon>pause</icon>
      Pause Session
    </button>
    <button variant="primary" size="lg" disabled="progress-incomplete">
      <icon>check-circle</icon>
      Complete Receiving (22/35)
    </button>
  </bottom-action-bar>
</screen>
```

---

## 8. Supplier Returns - List View

**Route:** `/inbound/supplier-returns`

**Purpose:** Manage return requests to suppliers

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Inbound → Supplier Returns</breadcrumbs>
    <button variant="primary">
      <icon>plus</icon>
      New Return Request
    </button>
  </page-header>
  
  <page-body>
    <!-- Filter Bar -->
    <filter-bar>
      <search-input placeholder="Search by return code, supplier..." />
      <filter-group>
        <filter-select label="Status">
          <option value="all">All Statuses</option>
          <option value="draft">Draft</option>
          <option value="pending">Pending Approval</option>
          <option value="approved">Approved</option>
          <option value="shipped">Shipped to Supplier</option>
          <option value="completed">Completed</option>
          <option value="rejected">Rejected</option>
        </filter-select>
        
        <filter-select label="Branch">
          <option value="all">All Branches</option>
        </filter-select>
        
        <date-range-picker label="Request Date" />
      </filter-group>
    </filter-bar>
    
    <!-- Summary Stats -->
    <stats-bar>
      <stat-chip>
        <label>Total Returns</label>
        <value>48</value>
      </stat-chip>
      <stat-chip color="orange">
        <label>Pending</label>
        <value>12</value>
      </stat-chip>
      <stat-chip color="blue">
        <label>In Process</label>
        <value>8</value>
      </stat-chip>
      <stat-chip color="green">
        <label>This Month</label>
        <value>15</value>
      </stat-chip>
    </stats-bar>
    
    <!-- Data Table -->
    <card>
      <card-body padding="none">
        <data-table responsive="card">
          <table-header>
            <column sortable="true">Return Code</column>
            <column sortable="true">Supplier</column>
            <column sortable="true">Branch</column>
            <column align="right">Items</column>
            <column align="right">Total Units</column>
            <column align="right">Expected Credit</column>
            <column sortable="true">Requested Date</column>
            <column sortable="true">Status</column>
            <column>Actions</column>
          </table-header>
          
          <table-body>
            <row clickable="true">
              <cell>
                <link monospace="true" weight="bold">RET-2024-012</link>
              </cell>
              <cell>ABC Suppliers Inc.</cell>
              <cell>Main Warehouse</cell>
              <cell align="right">3</cell>
              <cell align="right">45</cell>
              <cell align="right">$1,125.00</cell>
              <cell>Nov 8, 2024</cell>
              <cell>
                <badge color="orange">Pending Approval</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="primary">
                    <icon>check</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>Edit</menu-item>
                    <menu-item>Print</menu-item>
                    <menu-item color="danger">Cancel</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
        </data-table>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 9. Supplier Return - Detail View

**Route:** `/inbound/supplier-returns/:id`

**Purpose:** View and manage return request details

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>
      <link>Inbound</link> → <link>Supplier Returns</link> → RET-2024-012
    </breadcrumbs>
    <button-group>
      <button variant="outline">
        <icon>edit</icon>
        Edit
      </button>
      <button variant="outline">
        <icon>printer</icon>
        Print
      </button>
      <button variant="success">
        <icon>check</icon>
        Approve Return
      </button>
      <dropdown-menu>
        <menu-item>
          <icon>mail</icon>
          Email to Supplier
        </menu-item>
        <menu-item color="danger">
          <icon>x</icon>
          Reject Return
        </menu-item>
      </dropdown-menu>
    </button-group>
  </page-header>
  
  <page-body layout="grid">
    <!-- Return Info -->
    <card span="2">
      <card-header>
        <title-group>
          <title>Return Request RET-2024-012</title>
          <badge color="orange" size="lg">Pending Approval</badge>
        </title-group>
      </card-header>
      
      <card-body>
        <details-grid cols="3" cols-mobile="1">
          <detail-item>
            <label>Supplier</label>
            <value>
              <link>ABC Suppliers Inc.</link>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Branch</label>
            <value>Main Warehouse</value>
          </detail-item>
          
          <detail-item>
            <label>Requested By</label>
            <value>Sarah Controller</value>
          </detail-item>
          
          <detail-item>
            <label>Request Date</label>
            <value>Nov 8, 2024 3:20 PM</value>
          </detail-item>
          
          <detail-item>
            <label>Total Items</label>
            <value>3 SKUs</value>
          </detail-item>
          
          <detail-item>
            <label>Total Units</label>
            <value strong="true">45 units</value>
          </detail-item>
          
          <detail-item span="full">
            <label>Expected Credit Amount</label>
            <value strong="true" size="lg" color="green">$1,125.00</value>
          </detail-item>
        </details-grid>
      </card-body>
    </card>
    
    <!-- Supplier Contact -->
    <card span="1">
      <card-header>
        <title>Supplier Contact</title>
      </card-header>
      <card-body>
        <contact-info>
          <info-item>
            <icon>user</icon>
            <label>Contact</label>
            <value>John Smith</value>
          </info-item>
          <info-item>
            <icon>mail</icon>
            <label>Email</label>
            <value>
              <link>john@abcsuppliers.com</link>
            </value>
          </info-item>
          <info-item>
            <icon>phone</icon>
            <label>Phone</label>
            <value>
              <link>+1 (555) 123-4567</link>
            </value>
          </info-item>
        </contact-info>
      </card-body>
    </card>
    
    <!-- Return Items -->
    <card span="full">
      <card-header>
        <title>Items to Return</title>
      </card-header>
      
      <card-body padding="none">
        <data-table>
          <table-header>
            <column>SKU Code</column>
            <column>Product</column>
            <column>Batch Number</column>
            <column align="right">Quantity</column>
            <column>Reason</column>
            <column align="right">Unit Cost</column>
            <column align="right">Credit Amount</column>
          </table-header>
          
          <table-body>
            <row>
              <cell>
                <link monospace="true">SKU-1234-A</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Premium Widget Pro</text>
                  <text small="true" muted="true">Expired inventory</text>
                </stack>
              </cell>
              <cell>
                <badge monospace="true">B-2024-045</badge>
              </cell>
              <cell align="right">20</cell>
              <cell>
                <badge color="orange">Expired</badge>
              </cell>
              <cell align="right">$25.00</cell>
              <cell align="right" strong="true">$500.00</cell>
            </row>
            
            <row>
              <cell>
                <link monospace="true">SKU-5678-B</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Standard Gadget Plus</text>
                  <text small="true" muted="true">Damaged during receiving</text>
                </stack>
              </cell>
              <cell>
                <badge monospace="true">B-2024-052</badge>
              </cell>
              <cell align="right">15</cell>
              <cell>
                <badge color="red">Damaged</badge>
              </cell>
              <cell align="right">$30.00</cell>
              <cell align="right" strong="true">$450.00</cell>
            </row>
            
            <row>
              <cell>
                <link monospace="true">SKU-9012-C</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Deluxe Tool Set</text>
                  <text small="true" muted="true">Wrong item shipped</text>
                </stack>
              </cell>
              <cell>
                <badge monospace="true">B-2024-048</badge>
              </cell>
              <cell align="right">10</cell>
              <cell>
                <badge color="blue">Wrong Item</badge>
              </cell>
              <cell align="right">$17.50</cell>
              <cell align="right" strong="true">$175.00</cell>
            </row>
          </table-body>
          
          <table-footer>
            <summary-row highlight="true">
              <cell colspan="6" align="right" strong="true" size="lg">Total Expected Credit:</cell>
              <cell align="right" strong="true" size="lg" color="green">$1,125.00</cell>
            </summary-row>
          </table-footer>
        </data-table>
      </card-body>
    </card>
    
    <!-- Additional Details -->
    <card span="2">
      <card-header>
        <title>Return Reason & Notes</title>
      </card-header>
      <card-body>
        <text-content>
          <paragraph>
            <strong>Primary Reason:</strong> Mixed - Expired inventory, damaged goods, and incorrect items
          </paragraph>
          <paragraph>
            <strong>Additional Notes:</strong> Items were received as part of PO-2024-145. 
            Damage was noted during receiving inspection. Expired items were discovered during 
            routine inventory audit. Incorrect item (SKU-9012-C) should have been SKU-9012-D as 
            per original purchase order.
          </paragraph>
        </text-content>
      </card-body>
    </card>
    
    <!-- Photos/Evidence -->
    <card span="1">
      <card-header>
        <title>Evidence</title>
      </card-header>
      <card-body>
        <image-gallery cols="2">
          <image-thumb>
            <img src="damaged-item-1.jpg" alt="Damaged item" />
          </image-thumb>
          <image-thumb>
            <img src="expired-label.jpg" alt="Expired label" />
          </image-thumb>
        </image-gallery>
      </card-body>
    </card>
    
    <!-- Activity Timeline -->
    <card span="full">
      <card-header>
        <title>Return History</title>
      </card-header>
      <card-body>
        <timeline>
          <timeline-item status="current">
            <icon color="orange">clock</icon>
            <content>
              <title>Awaiting Approval</title>
              <meta>Pending manager review</meta>
            </content>
          </timeline-item>
          
          <timeline-item status="completed">
            <icon color="blue">file-text</icon>
            <content>
              <title>Return Request Created</title>
              <meta>Nov 8, 2024 3:20 PM • Created by: Sarah Controller</meta>
              <details>
                <text small="true">3 items totaling 45 units, expected credit: $1,125.00</text>
              </details>
            </content>
          </timeline-item>
        </timeline>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

This completes **Part 2: Inbound Operations**

---

## PART 3: OUTBOUND OPERATIONS

## 10. Outbound Orders - List View

**Route:** `/outbound/orders`

**Purpose:** View and manage all outbound/fulfillment orders

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Outbound → Orders</breadcrumbs>
    <button variant="primary">
      <icon>plus</icon>
      New Outbound Order
    </button>
  </page-header>
  
  <page-body>
    <!-- Filter Bar -->
    <filter-bar sticky="true">
      <search-input placeholder="Search by order code, tracking number..." />
      <filter-group>
        <filter-select label="Status">
          <option value="all">All Statuses</option>
          <option value="pending">Pending</option>
          <option value="picking">Picking</option>
          <option value="picked">Picked</option>
          <option value="packing">Packing</option>
          <option value="packed">Packed</option>
          <option value="shipped">Shipped</option>
          <option value="delivered">Delivered</option>
          <option value="cancelled">Cancelled</option>
        </filter-select>
        
        <filter-select label="Branch">
          <option value="all">All Branches</option>
        </filter-select>
        
        <filter-select label="Priority">
          <option value="all">All Priorities</option>
          <option value="urgent">Urgent</option>
          <option value="high">High</option>
          <option value="normal">Normal</option>
        </filter-select>
        
        <date-range-picker label="Ship Date" />
      </filter-group>
      
      <button-group>
        <button variant="ghost">
          <icon>filter</icon>
          Advanced Filters
        </button>
        <button variant="ghost">
          <icon>download</icon>
          Export
        </button>
      </button-group>
    </filter-bar>
    
    <!-- Summary Stats -->
    <stats-bar>
      <stat-chip>
        <label>Total Orders</label>
        <value>342</value>
      </stat-chip>
      <stat-chip color="orange">
        <label>Pending Picking</label>
        <value>45</value>
      </stat-chip>
      <stat-chip color="blue">
        <label>In Progress</label>
        <value>23</value>
      </stat-chip>
      <stat-chip color="green">
        <label>Shipped Today</label>
        <value>87</value>
      </stat-chip>
    </stats-bar>
    
    <!-- Data Table -->
    <card>
      <card-body padding="none">
        <data-table responsive="card" selection="multiple">
          <table-header>
            <column width="40px">
              <checkbox />
            </column>
            <column sortable="true" width="140px">Order Code</column>
            <column sortable="true">Customer/Destination</column>
            <column sortable="true">Branch</column>
            <column align="right">Items</column>
            <column sortable="true">Order Date</column>
            <column sortable="true">Ship Date</column>
            <column>Tracking</column>
            <column sortable="true">Status</column>
            <column>Priority</column>
            <column width="120px">Actions</column>
          </table-header>
          
          <table-body>
            <row clickable="true" highlight="urgent">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">OUT-2024-089</link>
              </cell>
              <cell>
                <stack>
                  <text>Customer ABC Corp</text>
                  <text small="true" muted="true">123 Main St, New York, NY</text>
                </stack>
              </cell>
              <cell>Main Warehouse</cell>
              <cell align="right">12</cell>
              <cell>Nov 8, 2024</cell>
              <cell>
                <stack>
                  <text>Nov 9, 2024</text>
                  <badge size="sm" color="red">Today</badge>
                </stack>
              </cell>
              <cell>
                <text muted="true" small="true">Not assigned</text>
              </cell>
              <cell>
                <badge color="orange">Pending Picking</badge>
              </cell>
              <cell>
                <badge color="red">Urgent</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="primary" title="Start Picking">
                    <icon>play</icon>
                  </button>
                  <button size="sm" variant="ghost" title="View">
                    <icon>eye</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>
                      <icon>edit</icon>
                      Edit
                    </menu-item>
                    <menu-item>
                      <icon>printer</icon>
                      Print Pick List
                    </menu-item>
                    <menu-item>
                      <icon>package</icon>
                      Print Packing Slip
                    </menu-item>
                    <divider />
                    <menu-item color="danger">
                      <icon>x</icon>
                      Cancel Order
                    </menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">OUT-2024-088</link>
              </cell>
              <cell>
                <stack>
                  <text>XYZ Retail Store</text>
                  <text small="true" muted="true">456 Oak Ave, Boston, MA</text>
                </stack>
              </cell>
              <cell>Main Warehouse</cell>
              <cell align="right">
                <progress-indicator inline="true">
                  <badge color="blue">8 / 24</badge>
                </progress-indicator>
              </cell>
              <cell>Nov 7, 2024</cell>
              <cell>Nov 9, 2024</cell>
              <cell>
                <text muted="true" small="true">Pending</text>
              </cell>
              <cell>
                <badge color="blue">Picking (33%)</badge>
              </cell>
              <cell>
                <badge color="orange">High</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="primary" title="Continue Picking">
                    <icon>play</icon>
                  </button>
                  <button size="sm" variant="ghost" title="View">
                    <icon>eye</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>Edit</menu-item>
                    <menu-item>Print Pick List</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">OUT-2024-087</link>
              </cell>
              <cell>
                <stack>
                  <text>Distribution Center 5</text>
                  <text small="true" muted="true">789 Industrial Pkwy, Chicago, IL</text>
                </stack>
              </cell>
              <cell>Main Warehouse</cell>
              <cell align="right">18</cell>
              <cell>Nov 6, 2024</cell>
              <cell>Nov 8, 2024</cell>
              <cell>
                <link monospace="true" small="true">TRK-1234567890</link>
              </cell>
              <cell>
                <badge color="green">Shipped</badge>
              </cell>
              <cell>
                <badge color="gray">Normal</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost" title="View">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="ghost" title="Track">
                    <icon>map-pin</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>View Details</menu-item>
                    <menu-item>Track Shipment</menu-item>
                    <menu-item>Reprint Label</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
        </data-table>
        
        <!-- Pagination -->
        <table-footer>
          <pagination>
            <page-info>Showing 1-20 of 342</page-info>
            <page-controls>
              <button disabled="true">Previous</button>
              <button active="true">1</button>
              <button>2</button>
              <button>3</button>
              <span>...</span>
              <button>18</button>
              <button>Next</button>
            </page-controls>
            <page-size-selector>
              <option>20 per page</option>
              <option>50 per page</option>
              <option>100 per page</option>
            </page-size-selector>
          </pagination>
        </table-footer>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 11. Outbound Order - Detail View

**Route:** `/outbound/orders/:id`

**Purpose:** View complete order details and manage fulfillment

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>
      <link>Outbound</link> → <link>Orders</link> → OUT-2024-089
    </breadcrumbs>
    <button-group>
      <button variant="outline">
        <icon>edit</icon>
        Edit
      </button>
      <button variant="outline">
        <icon>printer</icon>
        Print Pick List
      </button>
      <button variant="primary">
        <icon>play</icon>
        Start Picking
      </button>
      <dropdown-menu>
        <menu-item>
          <icon>package</icon>
          Print Packing Slip
        </menu-item>
        <menu-item>
          <icon>truck</icon>
          Print Shipping Label
        </menu-item>
        <menu-item>
          <icon>copy</icon>
          Duplicate Order
        </menu-item>
        <divider />
        <menu-item color="danger">
          <icon>x</icon>
          Cancel Order
        </menu-item>
      </dropdown-menu>
    </button-group>
  </page-header>
  
  <page-body layout="grid" gap="lg">
    <!-- Status Alert -->
    <alert-banner color="red" span="full" dismissible="false">
      <icon>alert-circle</icon>
      <content>
        <strong>Urgent Priority:</strong> This order must ship today by 4:00 PM
      </content>
    </alert-banner>
    
    <!-- Order Info -->
    <card span="2">
      <card-header>
        <title-group>
          <title>Outbound Order OUT-2024-089</title>
          <badge color="orange" size="lg">Pending Picking</badge>
          <badge color="red" size="lg">Urgent</badge>
        </title-group>
      </card-header>
      
      <card-body>
        <details-grid cols="3" cols-mobile="1">
          <detail-item>
            <label>Customer / Destination</label>
            <value>
              <stack>
                <text strong="true">Customer ABC Corp</text>
                <text small="true">123 Main St, New York, NY 10001</text>
              </stack>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Branch</label>
            <value>Main Warehouse</value>
          </detail-item>
          
          <detail-item>
            <label>Created By</label>
            <value>Sarah Manager</value>
          </detail-item>
          
          <detail-item>
            <label>Order Date</label>
            <value>Nov 8, 2024 9:15 AM</value>
          </detail-item>
          
          <detail-item>
            <label>Requested Ship Date</label>
            <value>
              <stack>
                <text>Nov 9, 2024</text>
                <badge size="sm" color="red">Today</badge>
              </stack>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Ship By Time</label>
            <value color="red" strong="true">4:00 PM</value>
          </detail-item>
          
          <detail-item>
            <label>Total Items</label>
            <value strong="true">12 items</value>
          </detail-item>
          
          <detail-item>
            <label>Picking Progress</label>
            <value>
              <progress-indicator>
                <value>0 / 12</value>
                <progress-bar value="0" />
              </progress-indicator>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Tracking Number</label>
            <value muted="true">Not assigned</value>
          </detail-item>
        </details-grid>
      </card-body>
    </card>
    
    <!-- Shipping Info -->
    <card span="1">
      <card-header>
        <title>Shipping Information</title>
      </card-header>
      <card-body>
        <shipping-details>
          <detail-section>
            <label>Ship To Address</label>
            <address-block>
              <text>Customer ABC Corp</text>
              <text>123 Main Street</text>
              <text>New York, NY 10001</text>
              <text>United States</text>
            </address-block>
          </detail-section>
          
          <detail-section>
            <label>Contact</label>
            <contact-block>
              <text>
                <icon>user</icon>
                John Customer
              </text>
              <text>
                <icon>phone</icon>
                <link>+1 (555) 987-6543</link>
              </text>
              <text>
                <icon>mail</icon>
                <link>john@abccorp.com</link>
              </text>
            </contact-block>
          </detail-section>
          
          <detail-section>
            <label>Shipping Method</label>
            <value>
              <badge color="blue">Express - Next Day</badge>
            </value>
          </detail-section>
        </shipping-details>
      </card-body>
    </card>
    
    <!-- Order Items with Picking Status -->
    <card span="full">
      <card-header>
        <title>Order Items</title>
        <search-input size="sm" placeholder="Search items..." />
      </card-header>
      
      <card-body padding="none">
        <data-table responsive="card">
          <table-header>
            <column width="60px">#</column>
            <column>SKU Code</column>
            <column>Product Description</column>
            <column align="right">Qty Requested</column>
            <column align="right">Qty Picked</column>
            <column align="right">Qty Packed</column>
            <column>Location</column>
            <column>Status</column>
            <column>Actions</column>
          </table-header>
          
          <table-body>
            <row>
              <cell>1</cell>
              <cell>
                <link monospace="true">SKU-1234-A</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Premium Widget Pro</text>
                  <text small="true" muted="true">Available: 50 units in stock</text>
                </stack>
              </cell>
              <cell align="right">5</cell>
              <cell align="right">
                <badge color="gray">0</badge>
              </cell>
              <cell align="right">
                <badge color="gray">0</badge>
              </cell>
              <cell>
                <badge color="purple" monospace="true">A-R1-S3</badge>
              </cell>
              <cell>
                <badge color="orange">Pending</badge>
              </cell>
              <cell>
                <button size="sm" variant="outline">
                  <icon>map-pin</icon>
                  Locate
                </button>
              </cell>
            </row>
            
            <row>
              <cell>2</cell>
              <cell>
                <link monospace="true">SKU-5678-B</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Standard Gadget Plus</text>
                  <text small="true" muted="true">Available: 150 units • Multiple zones</text>
                </stack>
              </cell>
              <cell align="right">10</cell>
              <cell align="right">
                <badge color="gray">0</badge>
              </cell>
              <cell align="right">
                <badge color="gray">0</badge>
              </cell>
              <cell>
                <stack>
                  <badge color="purple" monospace="true" size="sm">B-R2-S1 (6)</badge>
                  <badge color="purple" monospace="true" size="sm">A-R3-S2 (4)</badge>
                </stack>
              </cell>
              <cell>
                <badge color="orange">Pending</badge>
              </cell>
              <cell>
                <button size="sm" variant="outline">
                  <icon>map-pin</icon>
                  Locate
                </button>
              </cell>
            </row>
            
            <row highlight="warning">
              <cell>3</cell>
              <cell>
                <link monospace="true">SKU-9012-C</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Deluxe Tool Set</text>
                  <text small="true" color="orange">
                    <icon>alert-triangle</icon>
                    Only 3 units available - Short by 2
                  </text>
                </stack>
              </cell>
              <cell align="right">5</cell>
              <cell align="right">
                <badge color="gray">0</badge>
              </cell>
              <cell align="right">
                <badge color="gray">0</badge>
              </cell>
              <cell>
                <badge color="purple" monospace="true">C-R1-S4</badge>
              </cell>
              <cell>
                <badge color="orange">Insufficient Stock</badge>
              </cell>
              <cell>
                <button size="sm" variant="outline" color="orange">
                  <icon>alert-triangle</icon>
                  Resolve
                </button>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
        </data-table>
      </card-body>
    </card>
    
    <!-- Optimal Pick Path -->
    <card span="2">
      <card-header>
        <title>Suggested Pick Path</title>
        <badge color="blue">Optimized Route</badge>
      </card-header>
      <card-body>
        <pick-path-list>
          <path-step>
            <step-number>1</step-number>
            <step-content>
              <location>
                <icon>map-pin</icon>
                <zone-code>Zone A → Row 1 → Shelf 3</zone-code>
              </location>
              <items>
                <item>SKU-1234-A (5 units)</item>
              </items>
              <distance muted="true">Starting point</distance>
            </step-content>
          </path-step>
          
          <path-connector />
          
          <path-step>
            <step-number>2</step-number>
            <step-content>
              <location>
                <icon>map-pin</icon>
                <zone-code>Zone A → Row 3 → Shelf 2</zone-code>
              </location>
              <items>
                <item>SKU-5678-B (4 units)</item>
              </items>
              <distance muted="true">12 meters</distance>
            </step-content>
          </path-step>
          
          <path-connector />
          
          <path-step>
            <step-number>3</step-number>
            <step-content>
              <location>
                <icon>map-pin</icon>
                <zone-code>Zone B → Row 2 → Shelf 1</zone-code>
              </location>
              <items>
                <item>SKU-5678-B (6 units)</item>
                <item>SKU-7890-D (8 units)</item>
              </items>
              <distance muted="true">25 meters</distance>
            </step-content>
          </path-step>
          
          <!-- More steps... -->
        </pick-path-list>
        
        <path-summary>
          <summary-stat>
            <label>Total Distance</label>
            <value>87 meters</value>
          </summary-stat>
          <summary-stat>
            <label>Est. Time</label>
            <value>12 minutes</value>
          </summary-stat>
          <summary-stat>
            <label>Zones</label>
            <value>4</value>
          </summary-stat>
        </path-summary>
      </card-body>
      <card-footer>
        <button variant="primary" fullwidth="true">
          <icon>navigation</icon>
          Start Guided Picking
        </button>
      </card-footer>
    </card>
    
    <!-- Quick Actions -->
    <card span="1">
      <card-header>
        <title>Quick Actions</title>
      </card-header>
      <card-body>
        <action-list>
          <action-button fullwidth="true">
            <icon>printer</icon>
            Print Pick List
          </action-button>
          <action-button fullwidth="true">
            <icon>map</icon>
            View Warehouse Map
          </action-button>
          <action-button fullwidth="true">
            <icon>alert-circle</icon>
            Report Issue
          </action-button>
        </action-list>
      </card-body>
    </card>
    
    <!-- Activity Timeline -->
    <card span="full">
      <card-header>
        <title>Order History</title>
      </card-header>
      <card-body>
        <timeline>
          <timeline-item status="completed">
            <icon color="blue">file-text</icon>
            <content>
              <title>Outbound Order Created</title>
              <meta>Nov 8, 2024 9:15 AM • Created by: Sarah Manager</meta>
              <details>
                <text small="true">Order for Customer ABC Corp with 12 line items</text>
              </details>
            </content>
          </timeline-item>
        </timeline>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 12. Picking Work Session - Mobile Optimized

**Route:** `/outbound/picking/:sessionId`

**Purpose:** Mobile-optimized interface for picking items with guided navigation

**Layout:**

```html
<screen mode="fullscreen" optimize="mobile">
  <!-- Session Header -->
  <session-header fixed="true">
    <back-button />
    <session-info>
      <session-code monospace="true">PICK-2024-078</session-code>
      <session-timer live="true">00:08:45</session-timer>
    </session-info>
    <menu-button>
      <dropdown-menu position="bottom-right">
        <menu-item>
          <icon>pause</icon>
          Pause Session
        </menu-item>
        <menu-item>
          <icon>map</icon>
          View Full Map
        </menu-item>
        <menu-item>
          <icon>help-circle</icon>
          Help
        </menu-item>
        <divider />
        <menu-item color="danger">
          <icon>x</icon>
          Cancel Session
        </menu-item>
      </dropdown-menu>
    </menu-button>
  </session-header>
  
  <page-body padding="sm">
    <!-- Progress Summary -->
    <card>
      <card-body>
        <progress-summary>
          <progress-bar value="33" size="lg" animated="true">
            <label>4 of 12 items picked</label>
          </progress-bar>
          
          <stats-row>
            <stat>
              <value color="green">4</value>
              <label>Picked</label>
            </stat>
            <stat>
              <value color="orange">8</value>
              <label>Remaining</label>
            </stat>
            <stat>
              <value color="blue">OUT-2024-089</value>
              <label>Order</label>
            </stat>
          </stats-row>
        </progress-summary>
      </card-body>
    </card>
    
    <!-- Current Pick Instruction -->
    <card highlight="true" border-color="blue" size="lg">
      <card-header>
        <title>Current Pick</title>
        <badge color="blue">Step 3 of 6</badge>
      </card-header>
      
      <card-body>
        <!-- Navigation -->
        <navigation-card>
          <location-display size="lg">
            <icon size="xl">map-pin</icon>
            <zone-info>
              <zone-label>Go to Location</zone-label>
              <zone-code large="true">Zone B → Row 2 → Shelf 1</zone-code>
            </zone-info>
          </location-display>
          
          <distance-info>
            <icon>navigation</icon>
            <text>25 meters from previous pick</text>
          </distance-info>
          
          <mini-map>
            <map-view height="120px">
              <current-position marker="true" />
              <target-position marker="true" highlight="true" />
              <route-line color="blue" />
            </map-view>
          </mini-map>
          
          <button variant="outline" size="sm" fullwidth="true">
            <icon>maximize</icon>
            View Full Map
          </button>
        </navigation-card>
        
        <divider margin="md" />
        
        <!-- Items to Pick at This Location -->
        <items-to-pick>
          <section-title>Items at This Location</section-title>
          
          <pick-item-card>
            <item-image>
              <img src="product-thumb.jpg" alt="Product" />
            </item-image>
            <item-details>
              <sku-code monospace="true" strong="true">SKU-5678-B</sku-code>
              <product-name>Standard Gadget Plus</product-name>
              <quantity-needed>
                <icon>package</icon>
                Pick <strong>6 units</strong>
              </quantity-needed>
            </item-details>
          </pick-item-card>
          
          <pick-item-card>
            <item-image>
              <img src="product-thumb2.jpg" alt="Product" />
            </item-image>
            <item-details>
              <sku-code monospace="true" strong="true">SKU-7890-D</sku-code>
              <product-name>Professional Tool Kit</product-name>
              <quantity-needed>
                <icon>package</icon>
                Pick <strong>8 units</strong>
              </quantity-needed>
            </item-details>
          </pick-item-card>
        </items-to-pick>
      </card-body>
    </card>
    
    <!-- Scanner Section -->
    <card>
      <card-header>
        <title>Scan Items</title>
        <badge color="green" pulse="true">Ready</badge>
      </card-header>
      
      <card-body>
        <scanner-component>
          <button variant="primary" size="lg" fullwidth="true">
            <icon>camera</icon>
            Open Camera Scanner
          </button>
          
          <text-divider>or</text-divider>
          
          <input-group>
            <input 
              type="text" 
              placeholder="Enter SKU manually" 
              size="lg"
              autofocus="true"
            />
            <button variant="outline">
              <icon>arrow-right</icon>
            </button>
          </input-group>
        </scanner-component>
      </card-body>
    </card>
    
    <!-- After Scanning - Quantity Confirmation -->
    <card conditional="item-scanned">
      <card-header>
        <title>Confirm Pick</title>
        <badge color="green">Scanned: SKU-5678-B</badge>
      </card-header>
      
      <card-body>
        <scanned-item-display>
          <success-icon size="xl" color="green">
            <icon>check-circle</icon>
          </success-icon>
          <product-info text-align="center">
            <product-name strong="true" size="lg">Standard Gadget Plus</product-name>
            <sku-code monospace="true" muted="true">SKU-5678-B</sku-code>
          </product-info>
        </scanned-item-display>
        
        <form-section>
          <form-label>Quantity Picked</form-label>
          <quantity-input size="lg">
            <button type="button" variant="outline">
              <icon>minus</icon>
            </button>
            <input 
              type="number" 
              value="6" 
              min="0" 
              max="6"
              size="lg"
              text-align="center"
            />
            <button type="button" variant="outline">
              <icon>plus</icon>
            </button>
          </quantity-input>
          
          <helper-text>
            <icon>info</icon>
            Required: 6 units
          </helper-text>
        </form-section>
        
        <form-section>
          <form-label>Condition</form-label>
          <radio-group>
            <radio-button checked="true" fullwidth="true">
              <icon>check-circle</icon>
              Good Condition
            </radio-button>
            <radio-button fullwidth="true">
              <icon>alert-triangle</icon>
              Has Issues
            </radio-button>
          </radio-group>
        </form-section>
        
        <form-section conditional="has-issues">
          <form-label>Issue Details</form-label>
          <textarea rows="2" placeholder="Describe the issue..."></textarea>
        </form-section>
        
        <button-group layout="stack">
          <button variant="primary" size="lg" fullwidth="true">
            <icon>check</icon>
            Confirm Pick
          </button>
          <button variant="outline" size="lg" fullwidth="true">
            <icon>x</icon>
            Skip Item
          </button>
        </button-group>
      </card-body>
    </card>
    
    <!-- Picked Items Summary -->
    <card>
      <card-header>
        <title>Picked Items</title>
        <badge>4</badge>
      </card-header>
      
      <card-body padding="none">
        <list scrollable="true" max-height="250px">
          <list-item>
            <item-icon color="green">
              <icon>check</icon>
            </item-icon>
            <item-content>
              <item-title>SKU-1234-A</item-title>
              <item-subtitle>Premium Widget Pro</item-subtitle>
              <item-meta>Qty: 5 • Location: A-R1-S3 • 2:15 PM</item-meta>
            </item-content>
          </list-item>
          
          <list-item>
            <item-icon color="green">
              <icon>check</icon>
            </item-icon>
            <item-content>
              <item-title>SKU-5678-B</item-title>
              <item-subtitle>Standard Gadget Plus (Batch 1)</item-subtitle>
              <item-meta>Qty: 4 • Location: A-R3-S2 • 2:18 PM</item-meta>
            </item-content>
          </list-item>
          
          <!-- More items... -->
        </list>
      </card-body>
    </card>
    
    <!-- Remaining Picks -->
    <card>
      <card-header>
        <title>Next Picks</title>
        <badge color="orange">8</badge>
      </card-header>
      
      <card-body padding="none">
        <list>
          <list-item>
            <item-icon color="blue">
              <text strong="true">4</text>
            </item-icon>
            <item-content>
              <item-title>SKU-9012-C • Deluxe Tool Set</item-title>
              <item-meta>
                <icon>package</icon>
                3 units • 
                <icon>map-pin</icon>
                Zone C-R1-S4
              </item-meta>
            </item-content>
          </list-item>
          
          <!-- More items... -->
        </list>
      </card-body>
    </card>
  </page-body>
  
  <!-- Fixed Bottom Navigation -->
  <bottom-action-bar fixed="true" safe-area="true">
    <button variant="outline" size="lg">
      <icon>pause</icon>
      Pause
    </button>
    <button variant="ghost" size="lg">
      <icon>skip-forward</icon>
      Skip Location
    </button>
    <button variant="primary" size="lg" disabled="progress-incomplete">
      <icon>check-circle</icon>
      Complete (4/12)
    </button>
  </bottom-action-bar>
</screen>
```

---

## 13. Packing Station Interface

**Route:** `/outbound/packing/:orderId`

**Purpose:** Desktop/tablet optimized packing and shipping interface

**Layout:**

```html
<screen>
  <sidebar collapsible="true" />
  
  <page-header>
    <breadcrumbs>Outbound → Packing → OUT-2024-089</breadcrumbs>
    <order-status>
      <badge color="blue" size="lg">Ready for Packing</badge>
    </order-status>
  </page-header>
  
  <page-body layout="split" ratio="60-40">
    <!-- Left Panel - Packing Interface -->
    <main-panel>
      <!-- Order Summary -->
      <card>
        <card-body>
          <order-summary layout="horizontal">
            <summary-item>
              <label>Order</label>
              <value monospace="true" strong="true">OUT-2024-089</value>
            </summary-item>
            <summary-item>
              <label>Customer</label>
              <value>Customer ABC Corp</value>
            </summary-item>
            <summary-item>
              <label>Items</label>
              <value>12</value>
            </summary-item>
            <summary-item>
              <label>Ship Method</label>
              <badge color="blue">Express</badge>
            </summary-item>
          </order-summary>
        </card-body>
      </card>
      
      <!-- Scan & Pack -->
      <card>
        <card-header>
          <title>Scan Items to Pack</title>
          <progress-indicator inline="true">
            <text>0 / 12 packed</text>
          </progress-indicator>
        </card-header>
        
        <card-body>
          <!-- Scanner -->
          <scanner-section>
            <input-group size="lg">
              <input 
                type="text" 
                placeholder="Scan or enter SKU/Barcode..." 
                autofocus="true"
              />
              <button variant="primary">
                <icon>camera</icon>
                Scan
              </button>
            </input-group>
          </scanner-section>
          
          <!-- Scan Feedback -->
          <feedback-zone height="100px" conditional="item-scanned">
            <success-feedback animated="true">
              <icon size="xl" color="green">check-circle</icon>
              <text size="lg" strong="true">SKU-1234-A Verified</text>
              <text muted="true">Premium Widget Pro • Qty: 5</text>
            </success-feedback>
          </feedback-zone>
        </card-body>
      </card>
      
      <!-- Items to Pack -->
      <card>
        <card-header>
          <title>Items to Pack</title>
          <filter-chips>
            <chip active="true">All (12)</chip>
            <chip>Pending (12)</chip>
            <chip>Packed (0)</chip>
          </filter-chips>
        </card-header>
        
        <card-body padding="none">
          <data-table responsive="true">
            <table-header>
              <column width="40px"></column>
              <column>SKU</column>
              <column>Product</column>
              <column align="right">Qty Picked</column>
              <column align="right">Qty Packed</column>
              <column>Status</column>
              <column>Actions</column>
            </table-header>
            
            <table-body>
              <row>
                <cell>
                  <checkbox />
                </cell>
                <cell>
                  <text monospace="true">SKU-1234-A</text>
                </cell>
                <cell>
                  <stack>
                    <text>Premium Widget Pro</text>
                    <text small="true" muted="true">Box size: Medium</text>
                  </stack>
                </cell>
                <cell align="right">5</cell>
                <cell align="right">
                  <badge color="gray">0</badge>
                </cell>
                <cell>
                  <badge color="orange">Pending</badge>
                </cell>
                <cell>
                  <button size="sm" variant="outline">
                    <icon>package</icon>
                    Pack
                  </button>
                </cell>
              </row>
              
              <!-- More rows... -->
            </table-body>
          </data-table>
        </card-body>
      </card>
      
      <!-- Package Details -->
      <card>
        <card-header>
          <title>Package Information</title>
        </card-header>
        
        <card-body>
          <form-grid cols="2">
            <form-section>
              <form-label required="true">Package Type</form-label>
              <select size="lg">
                <option>Select package type...</option>
                <option>Small Box (10x8x6)</option>
                <option>Medium Box (16x12x10)</option>
                <option>Large Box (20x16x14)</option>
                <option>Custom Size</option>
              </select>
            </form-section>
            
            <form-section>
              <form-label>Package Weight (kg)</form-label>
              <input type="number" step="0.1" placeholder="0.0" size="lg" />
            </form-section>
            
            <form-section span="full">
              <form-label>Packing Notes</form-label>
              <textarea rows="2" placeholder="Special handling instructions..."></textarea>
            </form-section>
          </form-grid>
        </card-body>
      </card>
      
      <!-- Actions -->
      <card>
        <card-body>
          <button-group layout="horizontal">
            <button variant="outline" size="lg">
              <icon>printer</icon>
              Print Packing Slip
            </button>
            <button variant="primary" size="lg" fullwidth="true" disabled="not-complete">
              <icon>check-circle</icon>
              Complete Packing
            </button>
          </button-group>
        </card-body>
      </card>
    </main-panel>
    
    <!-- Right Panel - Order Details & Reference -->
    <side-panel>
      <!-- Customer Details -->
      <card>
        <card-header>
          <title>Shipping Address</title>
        </card-header>
        <card-body>
          <address-display>
            <text strong="true">Customer ABC Corp</text>
            <text>John Customer</text>
            <text>123 Main Street</text>
            <text>New York, NY 10001</text>
            <text>United States</text>
          </address-display>
          
          <divider margin="sm" />
          
          <contact-info>
            <info-item>
              <icon>phone</icon>
              <link>+1 (555) 987-6543</link>
            </info-item>
            <info-item>
              <icon>mail</icon>
              <link>john@abccorp.com</link>
            </info-item>
          </contact-info>
        </card-body>
      </card>
      
      <!-- Shipping Method -->
      <card>
        <card-header>
          <title>Shipping Method</title>
        </card-header>
        <card-body>
          <detail-item>
            <label>Carrier</label>
            <value>Express Shipping Co.</value>
          </detail-item>
          <detail-item>
            <label>Service</label>
            <value>
              <badge color="blue">Next Day Delivery</badge>
            </value>
          </detail-item>
          <detail-item>
            <label>Tracking</label>
            <value>
              <input type="text" placeholder="Enter tracking number..." />
            </value>
          </detail-item>
        </card-body>
      </card>
      
      <!-- Special Instructions -->
      <card>
        <card-header>
          <title>Special Instructions</title>
        </card-header>
        <card-body>
          <alert-box color="orange">
            <icon>alert-triangle</icon>
            <text>URGENT: Must ship by 4:00 PM today</text>
          </alert-box>
          
          <note-block margin-top="sm">
            <text muted="true">Customer requests signature upon delivery</text>
          </note-block>
        </card-body>
      </card>
      
      <!-- Packing History -->
      <card>
        <card-header>
          <title>Packing Progress</title>
        </card-header>
        <card-body>
          <timeline compact="true">
            <timeline-item status="current">
              <icon color="blue">package</icon>
              <content>
                <title>Packing Started</title>
                <time>Just now</time>
              </content>
            </timeline-item>
            <timeline-item status="completed">
              <icon color="green">check</icon>
              <content>
                <title>Picking Completed</title>
                <time>10 minutes ago</time>
              </content>
            </timeline-item>
          </timeline>
        </card-body>
      </card>
    </side-panel>
  </page-body>
</screen>
```

---

This completes **Part 3: Outbound Operations**

---

## PART 4: INVENTORY MANAGEMENT

## 14. Stock Overview - Inventory Dashboard

**Route:** `/inventory/stock`

**Purpose:** Real-time view of all inventory across branches and zones

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Inventory → Stock Overview</breadcrumbs>
    <button-group>
      <button variant="outline">
        <icon>download</icon>
        Export
      </button>
      <button variant="primary">
        <icon>refresh-cw</icon>
        Sync Inventory
      </button>
    </button-group>
  </page-header>
  
  <page-body>
    <!-- Filter & Search -->
    <filter-bar sticky="true">
      <search-input placeholder="Search by SKU, product name, batch..." />
      <filter-group>
        <filter-select label="Branch">
          <option value="all">All Branches</option>
        </filter-select>
        
        <filter-select label="Category">
          <option value="all">All Categories</option>
        </filter-select>
        
        <filter-select label="Status">
          <option value="all">All Stock Status</option>
          <option value="optimal">Optimal Stock</option>
          <option value="low">Low Stock</option>
          <option value="out">Out of Stock</option>
          <option value="overstock">Overstock</option>
        </filter-select>
        
        <filter-select label="Tracking">
          <option value="all">All Tracking Types</option>
          <option value="batch">Batch Tracked</option>
          <option value="serial">Serial Tracked</option>
        </filter-select>
      </filter-group>
    </filter-bar>
    
    <!-- Summary KPIs -->
    <kpi-row cols="5" gap="md">
      <kpi-card color="blue">
        <icon>package</icon>
        <label>Total SKUs</label>
        <value>1,847</value>
        <sublabel>Active products</sublabel>
      </kpi-card>
      
      <kpi-card color="green">
        <icon>check-circle</icon>
        <label>Optimal Stock</label>
        <value>1,456</value>
        <trend>79%</trend>
      </kpi-card>
      
      <kpi-card color="orange" alert="warning">
        <icon>alert-triangle</icon>
        <label>Low Stock</label>
        <value>342</value>
        <action>Review</action>
      </kpi-card>
      
      <kpi-card color="red" alert="danger">
        <icon>x-circle</icon>
        <label>Out of Stock</label>
        <value>23</value>
        <action>Urgent</action>
      </kpi-card>
      
      <kpi-card color="purple">
        <icon>dollar-sign</icon>
        <label>Total Value</label>
        <value>$2.4M</value>
        <sublabel>Current inventory</sublabel>
      </kpi-card>
    </kpi-row>
    
    <!-- Main Data Table -->
    <card>
      <card-header>
        <title>Inventory Items</title>
        <view-toggle>
          <button active="true">
            <icon>list</icon>
            Table
          </button>
          <button>
            <icon>grid</icon>
            Cards
          </button>
        </view-toggle>
      </card-header>
      
      <card-body padding="none">
        <data-table responsive="card" selection="multiple">
          <table-header>
            <column width="40px">
              <checkbox />
            </column>
            <column sortable="true">SKU Code</column>
            <column sortable="true">Product Name</column>
            <column>Category</column>
            <column align="right" sortable="true">On Hand</column>
            <column align="right">Reserved</column>
            <column align="right">Available</column>
            <column align="right">Reorder Point</column>
            <column>Stock Status</column>
            <column align="right">Value</column>
            <column>Tracking</column>
            <column width="120px">Actions</column>
          </table-header>
          
          <table-body>
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">SKU-1234-A</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Premium Widget Pro</text>
                  <text small="true" muted="true">Brand: TechCorp</text>
                </stack>
              </cell>
              <cell>
                <badge color="gray">Electronics</badge>
              </cell>
              <cell align="right" strong="true">156</cell>
              <cell align="right" muted="true">12</cell>
              <cell align="right">144</cell>
              <cell align="right">50</cell>
              <cell>
                <badge color="green">Optimal</badge>
              </cell>
              <cell align="right">$19,500</cell>
              <cell>
                <badge color="blue" size="sm">Batch</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost" title="View Details">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="ghost" title="View Batches">
                    <icon>layers</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>
                      <icon>edit</icon>
                      Adjust Quantity
                    </menu-item>
                    <menu-item>
                      <icon>move</icon>
                      Transfer
                    </menu-item>
                    <menu-item>
                      <icon>activity</icon>
                      View History
                    </menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true" highlight="warning">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">SKU-5678-B</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Standard Gadget Plus</text>
                  <text small="true" muted="true">Brand: BuildCo</text>
                </stack>
              </cell>
              <cell>
                <badge color="gray">Hardware</badge>
              </cell>
              <cell align="right" strong="true">35</cell>
              <cell align="right" muted="true">8</cell>
              <cell align="right">27</cell>
              <cell align="right">100</cell>
              <cell>
                <badge color="orange">Low Stock</badge>
              </cell>
              <cell align="right">$1,575</cell>
              <cell>
                <badge color="blue" size="sm">Batch</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="primary" title="Reorder">
                    <icon>shopping-cart</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>Adjust Quantity</menu-item>
                    <menu-item>View History</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true" highlight="danger">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">SKU-9012-C</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Deluxe Tool Set</text>
                  <text small="true" muted="true">Brand: ToolMaster</text>
                </stack>
              </cell>
              <cell>
                <badge color="gray">Tools</badge>
              </cell>
              <cell align="right" strong="true">0</cell>
              <cell align="right" muted="true">0</cell>
              <cell align="right" color="red">0</cell>
              <cell align="right">15</cell>
              <cell>
                <badge color="red">Out of Stock</badge>
              </cell>
              <cell align="right">$0</cell>
              <cell>
                <badge color="purple" size="sm">Serial</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="danger" title="Urgent Reorder">
                    <icon>alert-circle</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>Create Purchase Order</menu-item>
                    <menu-item>View History</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
        </data-table>
        
        <!-- Pagination -->
        <table-footer>
          <pagination>
            <page-info>Showing 1-50 of 1,847</page-info>
            <page-controls>
              <button disabled="true">Previous</button>
              <button active="true">1</button>
              <button>2</button>
              <button>3</button>
              <span>...</span>
              <button>37</button>
              <button>Next</button>
            </page-controls>
            <page-size-selector>
              <option>50 per page</option>
              <option>100 per page</option>
              <option>200 per page</option>
            </page-size-selector>
          </pagination>
        </table-footer>
      </card-body>
    </card>
    
    <!-- Bulk Actions Bar (when items selected) -->
    <bulk-actions-bar floating="true" conditional="has-selection">
      <selection-info>
        <text>5 items selected</text>
      </selection-info>
      <button-group>
        <button variant="outline">
          <icon>edit</icon>
          Bulk Adjust
        </button>
        <button variant="outline">
          <icon>move</icon>
          Bulk Transfer
        </button>
        <button variant="outline">
          <icon>download</icon>
          Export Selected
        </button>
      </button-group>
    </bulk-actions-bar>
  </page-body>
</screen>
```

---

## 15. SKU Detail View - Single Item

**Route:** `/inventory/stock/:skuId`

**Purpose:** Detailed view of a single SKU with batch/serial tracking

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>
      <link>Inventory</link> → <link>Stock</link> → SKU-1234-A
    </breadcrumbs>
    <button-group>
      <button variant="outline">
        <icon>edit</icon>
        Edit SKU
      </button>
      <button variant="outline">
        <icon>activity</icon>
        View Transactions
      </button>
      <dropdown-menu>
        <menu-item>
          <icon>shopping-cart</icon>
          Create Purchase Order
        </menu-item>
        <menu-item>
          <icon>move</icon>
          Transfer Stock
        </menu-item>
        <menu-item>
          <icon>edit</icon>
          Adjust Inventory
        </menu-item>
        <divider />
        <menu-item color="danger">
          <icon>archive</icon>
          Deactivate SKU
        </menu-item>
      </dropdown-menu>
    </button-group>
  </page-header>
  
  <page-body layout="grid">
    <!-- Product Info Card -->
    <card span="2">
      <card-body>
        <product-details layout="horizontal">
          <product-image size="120px">
            <img src="product.jpg" alt="Premium Widget Pro" />
          </product-image>
          
          <product-info>
            <sku-code monospace="true" muted="true">SKU-1234-A</sku-code>
            <product-name size="xl" strong="true">Premium Widget Pro</product-name>
            <product-meta>
              <meta-item>
                <icon>tag</icon>
                <text>Category: Electronics</text>
              </meta-item>
              <meta-item>
                <icon>award</icon>
                <text>Brand: TechCorp</text>
              </meta-item>
              <meta-item>
                <icon>package</icon>
                <text>UOM: Each</text>
              </meta-item>
            </product-meta>
            <badge-group margin-top="sm">
              <badge color="green">Active</badge>
              <badge color="blue">Batch Tracked</badge>
              <badge color="purple">Temperature Sensitive</badge>
            </badge-group>
          </product-info>
        </product-details>
      </card-body>
    </card>
    
    <!-- Stock Status Card -->
    <card span="1">
      <card-header>
        <title>Stock Status</title>
        <badge color="green" size="lg">Optimal</badge>
      </card-header>
      <card-body>
        <stock-metrics>
          <metric-item size="lg">
            <label>On Hand</label>
            <value strong="true" size="xl">156</value>
          </metric-item>
          
          <divider />
          
          <metric-item>
            <label>Reserved</label>
            <value muted="true">12</value>
          </metric-item>
          
          <metric-item>
            <label>Available</label>
            <value color="green" strong="true">144</value>
          </metric-item>
          
          <divider />
          
          <metric-item>
            <label>Reorder Point</label>
            <value>50</value>
          </metric-item>
          
          <metric-item>
            <label>Days of Supply</label>
            <value color="green">23 days</value>
          </metric-item>
        </stock-metrics>
      </card-body>
    </card>
    
    <!-- Valuation -->
    <card span="full">
      <card-header>
        <title>Valuation & Pricing</title>
      </card-header>
      <card-body>
        <details-grid cols="4" cols-mobile="2">
          <detail-item>
            <label>Cost Price</label>
            <value strong="true">$125.00</value>
          </detail-item>
          
          <detail-item>
            <label>Selling Price</label>
            <value strong="true">$199.00</value>
          </detail-item>
          
          <detail-item>
            <label>Total Inventory Value</label>
            <value strong="true" color="green" size="lg">$19,500.00</value>
          </detail-item>
          
          <detail-item>
            <label>Profit Margin</label>
            <value color="green">37%</value>
          </detail-item>
        </details-grid>
      </card-body>
    </card>
    
    <!-- Stock by Location -->
    <card span="full">
      <card-header>
        <title>Stock by Branch & Zone</title>
      </card-header>
      <card-body padding="none">
        <data-table>
          <table-header>
            <column>Branch</column>
            <column>Zone</column>
            <column align="right">Quantity</column>
            <column align="right">Reserved</column>
            <column align="right">Available</column>
            <column>Status</column>
            <column>Actions</column>
          </table-header>
          
          <table-body>
            <row>
              <cell>Main Warehouse</cell>
              <cell>
                <badge color="purple" monospace="true">A-R1-S3</badge>
              </cell>
              <cell align="right" strong="true">80</cell>
              <cell align="right" muted="true">6</cell>
              <cell align="right">74</cell>
              <cell>
                <badge color="green">Good</badge>
              </cell>
              <cell>
                <button size="sm" variant="outline">
                  <icon>move</icon>
                  Transfer
                </button>
              </cell>
            </row>
            
            <row>
              <cell>Main Warehouse</cell>
              <cell>
                <badge color="purple" monospace="true">B-R2-S4</badge>
              </cell>
              <cell align="right" strong="true">50</cell>
              <cell align="right" muted="true">4</cell>
              <cell align="right">46</cell>
              <cell>
                <badge color="green">Good</badge>
              </cell>
              <cell>
                <button size="sm" variant="outline">
                  <icon>move</icon>
                  Transfer
                </button>
              </cell>
            </row>
            
            <row>
              <cell>East Warehouse</cell>
              <cell>
                <badge color="purple" monospace="true">C-R1-S2</badge>
              </cell>
              <cell align="right" strong="true">26</cell>
              <cell align="right" muted="true">2</cell>
              <cell align="right">24</cell>
              <cell>
                <badge color="green">Good</badge>
              </cell>
              <cell>
                <button size="sm" variant="outline">
                  <icon>move</icon>
                  Transfer
                </button>
              </cell>
            </row>
          </table-body>
        </data-table>
      </card-body>
    </card>
    
    <!-- Batches List -->
    <card span="full">
      <card-header>
        <title>Active Batches</title>
        <badge>8 batches</badge>
      </card-header>
      <card-body padding="none">
        <data-table responsive="card">
          <table-header>
            <column>Batch Number</column>
            <column>Zone</column>
            <column align="right">Quantity</column>
            <column>Received Date</column>
            <column>Mfg Date</column>
            <column>Expiry Date</column>
            <column>Status</column>
            <column>Actions</column>
          </table-header>
          
          <table-body>
            <row>
              <cell>
                <link monospace="true">B-2024-089</link>
              </cell>
              <cell>
                <badge color="purple" monospace="true">A-R1-S3</badge>
              </cell>
              <cell align="right" strong="true">50</cell>
              <cell>Nov 5, 2024</cell>
              <cell>Oct 15, 2024</cell>
              <cell>Oct 15, 2026</cell>
              <cell>
                <badge color="green">Active</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="ghost">
                    <icon>activity</icon>
                  </button>
                </button-group>
              </cell>
            </row>
            
            <row highlight="warning">
              <cell>
                <link monospace="true">B-2024-045</link>
              </cell>
              <cell>
                <badge color="purple" monospace="true">B-R2-S4</badge>
              </cell>
              <cell align="right" strong="true">30</cell>
              <cell>Aug 20, 2024</cell>
              <cell>Jul 10, 2024</cell>
              <cell>
                <stack>
                  <text>Dec 10, 2024</text>
                  <badge size="sm" color="orange">31 days</badge>
                </stack>
              </cell>
              <cell>
                <badge color="orange">Expiring Soon</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="outline" color="orange">
                    <icon>alert-triangle</icon>
                  </button>
                </button-group>
              </cell>
            </row>
            
            <!-- More batches... -->
          </table-body>
        </data-table>
      </card-body>
    </card>
    
    <!-- Movement History Chart -->
    <card span="2">
      <card-header>
        <title>Stock Movement (Last 30 Days)</title>
        <button-group size="sm">
          <button active="true">30 Days</button>
          <button>90 Days</button>
          <button>1 Year</button>
        </button-group>
      </card-header>
      <card-body>
        <chart type="area" height="250px">
          <x-axis label="Date" />
          <y-axis label="Quantity" />
          <area label="Stock Level" color="blue" />
          <line label="Reorder Point" color="red" dashed="true" />
        </chart>
      </card-body>
    </card>
    
    <!-- Activity Stats -->
    <card span="1">
      <card-header>
        <title>Activity Summary</title>
        <subtitle>Last 30 Days</subtitle>
      </card-header>
      <card-body>
        <stat-list>
          <stat-item>
            <icon color="blue">arrow-down</icon>
            <content>
              <label>Received</label>
              <value strong="true">245 units</value>
            </content>
          </stat-item>
          
          <stat-item>
            <icon color="green">arrow-up</icon>
            <content>
              <label>Fulfilled</label>
              <value strong="true">189 units</value>
            </content>
          </stat-item>
          
          <stat-item>
            <icon color="orange">edit</icon>
            <content>
              <label>Adjustments</label>
              <value strong="true">2 times</value>
            </content>
          </stat-item>
          
          <stat-item>
            <icon color="purple">move</icon>
            <content>
              <label>Transfers</label>
              <value strong="true">3 times</value>
            </content>
          </stat-item>
        </stat-list>
      </card-body>
    </card>
    
    <!-- Recent Transactions -->
    <card span="full">
      <card-header>
        <title>Recent Transactions</title>
        <link>View All</link>
      </card-header>
      <card-body padding="none">
        <transaction-list>
          <transaction-item>
            <transaction-icon color="blue">
              <icon>arrow-down</icon>
            </transaction-icon>
            <transaction-content>
              <transaction-title>Stock Received</transaction-title>
              <transaction-subtitle>PO-2024-156 • Batch: B-2024-089</transaction-subtitle>
              <transaction-meta>Nov 5, 2024 2:45 PM • By: John Worker</transaction-meta>
            </transaction-content>
            <transaction-value color="green">+50 units</transaction-value>
          </transaction-item>
          
          <transaction-item>
            <transaction-icon color="green">
              <icon>arrow-up</icon>
            </transaction-icon>
            <transaction-content>
              <transaction-title>Order Fulfilled</transaction-title>
              <transaction-subtitle>OUT-2024-087 • Batch: B-2024-089</transaction-subtitle>
              <transaction-meta>Nov 4, 2024 3:20 PM • By: Sarah Worker</transaction-meta>
            </transaction-content>
            <transaction-value color="red">-15 units</transaction-value>
          </transaction-item>
          
          <transaction-item>
            <transaction-icon color="purple">
              <icon>move</icon>
            </transaction-icon>
            <transaction-content>
              <transaction-title>Internal Transfer</transaction-title>
              <transaction-subtitle>TRF-2024-045 • A-R1-S3 → B-R2-S4</transaction-subtitle>
              <transaction-meta>Nov 3, 2024 10:15 AM • By: Mike Worker</transaction-meta>
            </transaction-content>
            <transaction-value>20 units</transaction-value>
          </transaction-item>
        </transaction-list>
      </card-body>
    </card>
    
    <!-- Product Specifications -->
    <card span="1">
      <card-header>
        <title>Specifications</title>
      </card-header>
      <card-body>
        <spec-list>
          <spec-item>
            <label>Weight</label>
            <value>2.5 kg</value>
          </spec-item>
          <spec-item>
            <label>Volume</label>
            <value>0.015 m³</value>
          </spec-item>
          <spec-item>
            <label>Stacking Limit</label>
            <value>5 units</value>
          </spec-item>
          <spec-item>
            <label>Shelf Life</label>
            <value>730 days</value>
          </spec-item>
          <spec-item>
            <label>Storage Type</label>
            <value>
              <badge color="purple">Cold Storage</badge>
            </value>
          </spec-item>
        </spec-list>
      </card-body>
    </card>
    
    <!-- Barcodes -->
    <card span="2">
      <card-header>
        <title>Barcodes</title>
        <button size="sm" variant="ghost">
          <icon>plus</icon>
          Add Barcode
        </button>
      </card-header>
      <card-body>
        <barcode-list>
          <barcode-item>
            <barcode-image>
              <img src="barcode-ean13.png" alt="Barcode" />
            </barcode-image>
            <barcode-info>
              <barcode-type>EAN-13</barcode-type>
              <barcode-value monospace="true">1234567890123</barcode-value>
            </barcode-info>
            <barcode-actions>
              <button size="sm" variant="ghost">
                <icon>printer</icon>
              </button>
              <button size="sm" variant="ghost">
                <icon>copy</icon>
              </button>
            </barcode-actions>
          </barcode-item>
          
          <barcode-item>
            <barcode-image>
              <img src="barcode-qr.png" alt="QR Code" />
            </barcode-image>
            <barcode-info>
              <barcode-type>QR Code</barcode-type>
              <barcode-value monospace="true">SKU-1234-A-QR-001</barcode-value>
            </barcode-info>
            <barcode-actions>
              <button size="sm" variant="ghost">
                <icon>printer</icon>
              </button>
              <button size="sm" variant="ghost">
                <icon>copy</icon>
              </button>
            </barcode-actions>
          </barcode-item>
        </barcode-list>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 16. Batch Tracking View

**Route:** `/inventory/batches`

**Purpose:** View and manage all inventory batches across the warehouse

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Inventory → Batch Tracking</breadcrumbs>
    <button variant="primary">
      <icon>plus</icon>
      Create Manual Batch
    </button>
  </page-header>
  
  <page-body>
    <!-- Filter Bar -->
    <filter-bar sticky="true">
      <search-input placeholder="Search by batch number, SKU, supplier..." />
      <filter-group>
        <filter-select label="Branch">
          <option value="all">All Branches</option>
        </filter-select>
        
        <filter-select label="Status">
          <option value="all">All Statuses</option>
          <option value="active">Active</option>
          <option value="expiring">Expiring Soon</option>
          <option value="expired">Expired</option>
          <option value="quarantine">Quarantined</option>
          <option value="depleted">Depleted</option>
        </filter-select>
        
        <date-range-picker label="Expiry Date Range" />
        
        <filter-select label="Zone">
          <option value="all">All Zones</option>
        </filter-select>
      </filter-group>
    </filter-bar>
    
    <!-- Summary Stats -->
    <stats-bar>
      <stat-chip color="green">
        <label>Active Batches</label>
        <value>1,247</value>
      </stat-chip>
      <stat-chip color="orange">
        <label>Expiring (30 days)</label>
        <value>142</value>
      </stat-chip>
      <stat-chip color="red">
        <label>Expired</label>
        <value>8</value>
      </stat-chip>
      <stat-chip color="gray">
        <label>Quarantined</label>
        <value>3</value>
      </stat-chip>
    </stats-bar>
    
    <!-- Batch List -->
    <card>
      <card-body padding="none">
        <data-table responsive="card" selection="multiple">
          <table-header>
            <column width="40px">
              <checkbox />
            </column>
            <column sortable="true">Batch Number</column>
            <column sortable="true">SKU</column>
            <column>Product</column>
            <column>Branch / Zone</column>
            <column align="right" sortable="true">Quantity</column>
            <column sortable="true">Received</column>
            <column sortable="true">Mfg Date</column>
            <column sortable="true">Expiry Date</column>
            <column sortable="true">Status</column>
            <column>Actions</column>
          </table-header>
          
          <table-body>
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">B-2024-089</link>
              </cell>
              <cell>
                <link monospace="true">SKU-1234-A</link>
              </cell>
              <cell>
                <stack>
                  <text>Premium Widget Pro</text>
                  <text small="true" muted="true">Supplier: ABC Suppliers</text>
                </stack>
              </cell>
              <cell>
                <stack>
                  <text>Main Warehouse</text>
                  <badge color="purple" size="sm" monospace="true">A-R1-S3</badge>
                </stack>
              </cell>
              <cell align="right" strong="true">50</cell>
              <cell>Nov 5, 2024</cell>
              <cell>Oct 15, 2024</cell>
              <cell>
                <stack>
                  <text>Oct 15, 2026</text>
                  <text small="true" muted="true">622 days</text>
                </stack>
              </cell>
              <cell>
                <badge color="green">Active</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost" title="View">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="ghost" title="History">
                    <icon>activity</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>
                      <icon>move</icon>
                      Move Batch
                    </menu-item>
                    <menu-item>
                      <icon>edit</icon>
                      Adjust Quantity
                    </menu-item>
                    <menu-item>
                      <icon>printer</icon>
                      Print Label
                    </menu-item>
                    <divider />
                    <menu-item color="danger">
                      <icon>alert-triangle</icon>
                      Quarantine
                    </menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true" highlight="warning">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">B-2024-045</link>
              </cell>
              <cell>
                <link monospace="true">SKU-1234-A</link>
              </cell>
              <cell>
                <stack>
                  <text>Premium Widget Pro</text>
                  <text small="true" muted="true">Supplier: ABC Suppliers</text>
                </stack>
              </cell>
              <cell>
                <stack>
                  <text>Main Warehouse</text>
                  <badge color="purple" size="sm" monospace="true">B-R2-S4</badge>
                </stack>
              </cell>
              <cell align="right" strong="true">30</cell>
              <cell>Aug 20, 2024</cell>
              <cell>Jul 10, 2024</cell>
              <cell>
                <stack>
                  <text color="orange">Dec 10, 2024</text>
                  <badge size="sm" color="orange">31 days left</badge>
                </stack>
              </cell>
              <cell>
                <badge color="orange">Expiring Soon</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="outline" color="orange" title="Take Action">
                    <icon>alert-triangle</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>Prioritize for Outbound</menu-item>
                    <menu-item>Create Return Request</menu-item>
                    <menu-item>Transfer to Clearance</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true" highlight="danger">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">B-2024-023</link>
              </cell>
              <cell>
                <link monospace="true">SKU-5678-B</link>
              </cell>
              <cell>
                <stack>
                  <text>Standard Gadget Plus</text>
                  <text small="true" muted="true">Supplier: XYZ Distribution</text>
                </stack>
              </cell>
              <cell>
                <stack>
                  <text>Main Warehouse</text>
                  <badge color="gray" size="sm" monospace="true">Q-R1-S1</badge>
                </stack>
              </cell>
              <cell align="right" strong="true" color="red">12</cell>
              <cell>Jun 15, 2024</cell>
              <cell>May 1, 2024</cell>
              <cell>
                <stack>
                  <text color="red">Nov 1, 2024</text>
                  <badge size="sm" color="red">Expired 8 days ago</badge>
                </stack>
              </cell>
              <cell>
                <badge color="red">Expired</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="danger" title="Process Disposal">
                    <icon>trash-2</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>Create Return Request</menu-item>
                    <menu-item color="danger">Process Disposal</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
        </data-table>
        
        <!-- Pagination -->
        <table-footer>
          <pagination>
            <page-info>Showing 1-50 of 1,247</page-info>
            <page-controls>
              <button disabled="true">Previous</button>
              <button active="true">1</button>
              <button>2</button>
              <button>3</button>
              <span>...</span>
              <button>25</button>
              <button>Next</button>
            </page-controls>
          </pagination>
        </table-footer>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 17. Serial Number Tracking View

**Route:** `/inventory/serials`

**Purpose:** Track individual serial-numbered items

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Inventory → Serial Number Tracking</breadcrumbs>
    <search-bar size="lg" placeholder="Search by serial number..." autofocus="true" />
  </page-header>
  
  <page-body>
    <!-- Filter Bar -->
    <filter-bar>
      <filter-group>
        <filter-select label="SKU">
          <option value="all">All SKUs</option>
          <!-- Serial-tracked SKUs only -->
        </filter-select>
        
        <filter-select label="Status">
          <option value="all">All Statuses</option>
          <option value="in-stock">In Stock</option>
          <option value="reserved">Reserved</option>
          <option value="sold">Sold</option>
          <option value="defective">Defective</option>
          <option value="returned">Returned</option>
        </filter-select>
        
        <filter-select label="Branch">
          <option value="all">All Branches</option>
        </filter-select>
        
        <date-range-picker label="Received Date" />
      </filter-group>
    </filter-bar>
    
    <!-- Summary Stats -->
    <stats-bar>
      <stat-chip color="blue">
        <label>Total Serials</label>
        <value>3,456</value>
      </stat-chip>
      <stat-chip color="green">
        <label>In Stock</label>
        <value>2,847</value>
      </stat-chip>
      <stat-chip color="orange">
        <label>Reserved</label>
        <value>234</value>
      </stat-chip>
      <stat-chip color="red">
        <label>Defective</label>
        <value>23</value>
      </stat-chip>
    </stats-bar>
    
    <!-- Serial Numbers Table -->
    <card>
      <card-body padding="none">
        <data-table responsive="card">
          <table-header>
            <column sortable="true">Serial Number</column>
            <column sortable="true">SKU</column>
            <column>Product</column>
            <column>Batch</column>
            <column>Location</column>
            <column sortable="true">Warranty Expires</column>
            <column sortable="true">Status</column>
            <column>Actions</column>
          </table-header>
          
          <table-body>
            <row clickable="true">
              <cell>
                <link monospace="true" weight="bold">SN-2024-001234</link>
              </cell>
              <cell>
                <link monospace="true">SKU-9012-C</link>
              </cell>
              <cell>
                <text>Deluxe Tool Set</text>
              </cell>
              <cell>
                <link monospace="true" small="true">B-2024-078</link>
              </cell>
              <cell>
                <stack>
                  <text>Main Warehouse</text>
                  <badge color="purple" size="sm" monospace="true">C-R1-S4</badge>
                </stack>
              </cell>
              <cell>
                <stack>
                  <text>Nov 5, 2026</text>
                  <text small="true" muted="true">2 years</text>
                </stack>
              </cell>
              <cell>
                <badge color="green">In Stock</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost" title="View History">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="ghost" title="Print Label">
                    <icon>printer</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>View Full History</menu-item>
                    <menu-item>Transfer</menu-item>
                    <menu-item color="danger">Mark as Defective</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
        </data-table>
        
        <!-- Pagination -->
        <table-footer>
          <pagination>
            <page-info>Showing 1-50 of 3,456</page-info>
            <page-controls>
              <button disabled="true">Previous</button>
              <button active="true">1</button>
              <button>2</button>
              <button>3</button>
              <span>...</span>
              <button>70</button>
              <button>Next</button>
            </page-controls>
          </pagination>
        </table-footer>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

This completes **Part 4: Inventory Management** (Sections 14-17)

---

## PART 5: INVENTORY ADJUSTMENTS & TRANSFERS

## 18. Inventory Adjustments - List View

**Route:** `/inventory/adjustments`

**Purpose:** View and manage inventory adjustment requests

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Inventory → Adjustments</breadcrumbs>
    <button variant="primary">
      <icon>plus</icon>
      New Adjustment Request
    </button>
  </page-header>
  
  <page-body>
    <!-- Filter Bar -->
    <filter-bar sticky="true">
      <search-input placeholder="Search by request code, SKU..." />
      <filter-group>
        <filter-select label="Status">
          <option value="all">All Statuses</option>
          <option value="draft">Draft</option>
          <option value="pending">Pending Approval</option>
          <option value="approved">Approved</option>
          <option value="rejected">Rejected</option>
          <option value="completed">Completed</option>
        </filter-select>
        
        <filter-select label="Reason">
          <option value="all">All Reasons</option>
          <option value="cycle-count">Cycle Count</option>
          <option value="damage">Damage</option>
          <option value="expiry">Expiry</option>
          <option value="theft">Theft/Loss</option>
          <option value="found">Found/Recovered</option>
          <option value="other">Other</option>
        </filter-select>
        
        <filter-select label="Branch">
          <option value="all">All Branches</option>
        </filter-select>
        
        <date-range-picker label="Request Date" />
      </filter-group>
    </filter-bar>
    
    <!-- Summary Stats -->
    <stats-bar>
      <stat-chip>
        <label>Total Requests</label>
        <value>189</value>
      </stat-chip>
      <stat-chip color="orange">
        <label>Pending Approval</label>
        <value>12</value>
      </stat-chip>
      <stat-chip color="blue">
        <label>This Month</label>
        <value>34</value>
      </stat-chip>
      <stat-chip color="red">
        <label>Negative Impact</label>
        <value>-$2,345</value>
      </stat-chip>
    </stats-bar>
    
    <!-- Adjustments Table -->
    <card>
      <card-body padding="none">
        <data-table responsive="card" selection="multiple">
          <table-header>
            <column width="40px">
              <checkbox />
            </column>
            <column sortable="true">Request Code</column>
            <column>Type</column>
            <column>SKU / Batch</column>
            <column>Branch</column>
            <column align="right">Variance</column>
            <column align="right">Cost Impact</column>
            <column sortable="true">Requested By</column>
            <column sortable="true">Date</column>
            <column sortable="true">Status</column>
            <column>Actions</column>
          </table-header>
          
          <table-body>
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">ADJ-2024-001</link>
              </cell>
              <cell>
                <badge color="blue">Cycle Count</badge>
              </cell>
              <cell>
                <stack>
                  <link monospace="true">SKU-1234-A</link>
                  <text small="true" muted="true">Batch: B-2024-089</text>
                </stack>
              </cell>
              <cell>Main Warehouse</cell>
              <cell align="right">
                <badge color="red">-15</badge>
              </cell>
              <cell align="right" color="red">-$1,875.00</cell>
              <cell>John Controller</cell>
              <cell>Nov 9, 10:30 AM</cell>
              <cell>
                <badge color="orange">Pending Approval</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="primary">
                    <icon>check</icon>
                  </button>
                  <button size="sm" variant="ghost" title="View">
                    <icon>eye</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>
                      <icon>check</icon>
                      Approve
                    </menu-item>
                    <menu-item color="danger">
                      <icon>x</icon>
                      Reject
                    </menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">ADJ-2024-002</link>
              </cell>
              <cell>
                <badge color="red">Damage</badge>
              </cell>
              <cell>
                <stack>
                  <link monospace="true">SKU-5678-B</link>
                  <text small="true" muted="true">Batch: B-2024-052</text>
                </stack>
              </cell>
              <cell>Main Warehouse</cell>
              <cell align="right">
                <badge color="red">-8</badge>
              </cell>
              <cell align="right" color="red">-$360.00</cell>
              <cell>Sarah Worker</cell>
              <cell>Nov 9, 9:15 AM</cell>
              <cell>
                <badge color="orange">Pending Approval</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="primary">
                    <icon>check</icon>
                  </button>
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>Approve</menu-item>
                    <menu-item color="danger">Reject</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">ADJ-2024-003</link>
              </cell>
              <cell>
                <badge color="green">Found</badge>
              </cell>
              <cell>
                <stack>
                  <link monospace="true">SKU-9012-C</link>
                  <text small="true" muted="true">Batch: B-2024-078</text>
                </stack>
              </cell>
              <cell>East Warehouse</cell>
              <cell align="right">
                <badge color="green">+5</badge>
              </cell>
              <cell align="right" color="green">+$87.50</cell>
              <cell>Mike Worker</cell>
              <cell>Nov 8, 3:45 PM</cell>
              <cell>
                <badge color="green">Approved</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="ghost">
                    <icon>activity</icon>
                  </button>
                </button-group>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
        </data-table>
        
        <!-- Pagination -->
        <table-footer>
          <pagination>
            <page-info>Showing 1-20 of 189</page-info>
            <page-controls>
              <button disabled="true">Previous</button>
              <button active="true">1</button>
              <button>2</button>
              <button>3</button>
              <span>...</span>
              <button>10</button>
              <button>Next</button>
            </page-controls>
          </pagination>
        </table-footer>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 19. Adjustment Request - Detail/Create View

**Route:** `/inventory/adjustments/:id` or `/inventory/adjustments/new`

**Purpose:** Create or review detailed adjustment request

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>
      <link>Inventory</link> → <link>Adjustments</link> → ADJ-2024-001
    </breadcrumbs>
    <button-group conditional="pending-approval">
      <button variant="success">
        <icon>check</icon>
        Approve Request
      </button>
      <button variant="danger">
        <icon>x</icon>
        Reject Request
      </button>
    </button-group>
  </page-header>
  
  <page-body layout="grid">
    <!-- Request Info -->
    <card span="2">
      <card-header>
        <title-group>
          <title>Adjustment Request ADJ-2024-001</title>
          <badge color="orange" size="lg">Pending Approval</badge>
        </title-group>
      </card-header>
      
      <card-body>
        <details-grid cols="3" cols-mobile="1">
          <detail-item>
            <label>Request Type</label>
            <value>
              <badge color="blue">Cycle Count Variance</badge>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Branch</label>
            <value>Main Warehouse</value>
          </detail-item>
          
          <detail-item>
            <label>Requested By</label>
            <value>John Controller</value>
          </detail-item>
          
          <detail-item>
            <label>Request Date</label>
            <value>Nov 9, 2024 10:30 AM</value>
          </detail-item>
          
          <detail-item>
            <label>Items</label>
            <value strong="true">3 SKUs</value>
          </detail-item>
          
          <detail-item>
            <label>Total Variance</label>
            <value strong="true" color="red">-22 units</value>
          </detail-item>
          
          <detail-item span="full">
            <label>Total Cost Impact</label>
            <value strong="true" size="lg" color="red">-$1,875.00</value>
          </detail-item>
        </details-grid>
      </card-body>
    </card>
    
    <!-- Approval Status -->
    <card span="1" conditional="pending-approval">
      <card-header>
        <title>Approval Required</title>
      </card-header>
      <card-body>
        <alert-box color="orange">
          <icon>alert-circle</icon>
          <text>This adjustment requires manager approval before processing</text>
        </alert-box>
        
        <form-section margin-top="md">
          <form-label>Approval Decision</form-label>
          <button-group layout="stack">
            <button variant="success" size="lg" fullwidth="true">
              <icon>check-circle</icon>
              Approve & Process
            </button>
            <button variant="danger" size="lg" fullwidth="true">
              <icon>x-circle</icon>
              Reject Request
            </button>
          </button-group>
        </form-section>
      </card-body>
    </card>
    
    <!-- Adjustment Items -->
    <card span="full">
      <card-header>
        <title>Adjustment Items</title>
      </card-header>
      
      <card-body padding="none">
        <data-table>
          <table-header>
            <column>SKU Code</column>
            <column>Product</column>
            <column>Batch Number</column>
            <column>Zone</column>
            <column align="right">Expected Qty</column>
            <column align="right">Actual Qty</column>
            <column align="right">Variance</column>
            <column>Reason</column>
            <column align="right">Cost Impact</column>
          </table-header>
          
          <table-body>
            <row>
              <cell>
                <link monospace="true">SKU-1234-A</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Premium Widget Pro</text>
                  <text small="true" muted="true">Cost: $125.00/unit</text>
                </stack>
              </cell>
              <cell>
                <link monospace="true">B-2024-089</link>
              </cell>
              <cell>
                <badge color="purple" monospace="true">A-R1-S3</badge>
              </cell>
              <cell align="right">50</cell>
              <cell align="right">35</cell>
              <cell align="right">
                <badge color="red">-15</badge>
              </cell>
              <cell>
                <badge color="blue">Cycle Count</badge>
              </cell>
              <cell align="right" color="red">-$1,875.00</cell>
            </row>
            
            <row>
              <cell>
                <link monospace="true">SKU-5678-B</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Standard Gadget Plus</text>
                  <text small="true" muted="true">Cost: $45.50/unit</text>
                </stack>
              </cell>
              <cell>
                <link monospace="true">B-2024-052</link>
              </cell>
              <cell>
                <badge color="purple" monospace="true">B-R2-S1</badge>
              </cell>
              <cell align="right">100</cell>
              <cell align="right">95</cell>
              <cell align="right">
                <badge color="red">-5</badge>
              </cell>
              <cell>
                <badge color="blue">Cycle Count</badge>
              </cell>
              <cell align="right" color="red">-$227.50</cell>
            </row>
            
            <row>
              <cell>
                <link monospace="true">SKU-9012-C</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Deluxe Tool Set</text>
                  <text small="true" muted="true">Cost: $17.50/unit</text>
                </stack>
              </cell>
              <cell>
                <link monospace="true">B-2024-078</link>
              </cell>
              <cell>
                <badge color="purple" monospace="true">C-R1-S4</badge>
              </cell>
              <cell align="right">20</cell>
              <cell align="right">18</cell>
              <cell align="right">
                <badge color="red">-2</badge>
              </cell>
              <cell>
                <badge color="blue">Cycle Count</badge>
              </cell>
              <cell align="right" color="red">-$35.00</cell>
            </row>
          </table-body>
          
          <table-footer>
            <summary-row highlight="true">
              <cell colspan="6" align="right" strong="true">Total Variance:</cell>
              <cell align="right" strong="true">
                <badge color="red" size="lg">-22 units</badge>
              </cell>
              <cell></cell>
              <cell align="right" strong="true" size="lg" color="red">-$2,137.50</cell>
            </summary-row>
          </table-footer>
        </data-table>
      </card-body>
    </card>
    
    <!-- Reason & Notes -->
    <card span="2">
      <card-header>
        <title>Adjustment Reason & Details</title>
      </card-header>
      <card-body>
        <detail-section>
          <label strong="true">Primary Reason</label>
          <value>
            <badge color="blue">Cycle Count Variance</badge>
          </value>
        </detail-section>
        
        <detail-section margin-top="md">
          <label strong="true">Detailed Notes</label>
          <text-content>
            <paragraph>
              Physical count conducted on Nov 9, 2024 during scheduled cycle count of Zone A, B, and C.
              Discrepancies found in multiple batches. All items physically verified twice for accuracy.
            </paragraph>
            <paragraph>
              Possible causes: Recent high-volume picking activities may have resulted in missed scans
              or incorrect quantity confirmations. Recommend additional training for picking staff.
            </paragraph>
          </text-content>
        </detail-section>
      </card-body>
    </card>
    
    <!-- Supporting Evidence -->
    <card span="1">
      <card-header>
        <title>Supporting Evidence</title>
      </card-header>
      <card-body>
        <file-list>
          <file-item>
            <file-icon type="pdf" />
            <file-info>
              <file-name>cycle-count-report.pdf</file-name>
              <file-meta>245 KB</file-meta>
            </file-info>
            <file-actions>
              <button size="sm" variant="ghost">
                <icon>download</icon>
              </button>
            </file-actions>
          </file-item>
          
          <file-item>
            <file-icon type="image" />
            <file-info>
              <file-name>zone-a-photo.jpg</file-name>
              <file-meta>1.2 MB</file-meta>
            </file-info>
            <file-actions>
              <button size="sm" variant="ghost">
                <icon>eye</icon>
              </button>
              <button size="sm" variant="ghost">
                <icon>download</icon>
              </button>
            </file-actions>
          </file-item>
        </file-list>
      </card-body>
    </card>
    
    <!-- Timeline -->
    <card span="full">
      <card-header>
        <title>Request History</title>
      </card-header>
      <card-body>
        <timeline>
          <timeline-item status="current">
            <icon color="orange">clock</icon>
            <content>
              <title>Pending Manager Approval</title>
              <meta>Awaiting review</meta>
            </content>
          </timeline-item>
          
          <timeline-item status="completed">
            <icon color="blue">file-text</icon>
            <content>
              <title>Adjustment Request Created</title>
              <meta>Nov 9, 2024 10:30 AM • Created by: John Controller</meta>
              <details>
                <text small="true">3 items with total variance of -22 units</text>
              </details>
            </content>
          </timeline-item>
          
          <timeline-item status="completed">
            <icon color="blue">check-square</icon>
            <content>
              <title>Physical Count Completed</title>
              <meta>Nov 9, 2024 10:00 AM • Conducted by: John Controller</meta>
            </content>
          </timeline-item>
        </timeline>
      </card-body>
    </card>
    
    <!-- Approval Form (for managers) -->
    <card span="full" conditional="can-approve">
      <card-header>
        <title>Approval Decision</title>
      </card-header>
      <card-body>
        <form-section>
          <form-label>Decision Notes (Optional)</form-label>
          <textarea 
            rows="3" 
            placeholder="Add any comments about your decision..."
          ></textarea>
        </form-section>
        
        <button-group margin-top="md">
          <button variant="success" size="lg">
            <icon>check-circle</icon>
            Approve & Process Adjustment
          </button>
          <button variant="danger" size="lg">
            <icon>x-circle</icon>
            Reject Request
          </button>
          <button variant="outline" size="lg">
            <icon>message-circle</icon>
            Request More Info
          </button>
        </button-group>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 20. Stock Transfer - List View

**Route:** `/inventory/transfers`

**Purpose:** Manage stock transfers between branches or zones

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Inventory → Stock Transfers</breadcrumbs>
    <button variant="primary">
      <icon>plus</icon>
      New Transfer Order
    </button>
  </page-header>
  
  <page-body>
    <!-- Filter Bar -->
    <filter-bar sticky="true">
      <search-input placeholder="Search by transfer code..." />
      <filter-group>
        <filter-select label="Status">
          <option value="all">All Statuses</option>
          <option value="draft">Draft</option>
          <option value="pending">Pending</option>
          <option value="in-transit">In Transit</option>
          <option value="received">Received</option>
          <option value="completed">Completed</option>
          <option value="cancelled">Cancelled</option>
        </filter-select>
        
        <filter-select label="Source Branch">
          <option value="all">All Branches</option>
        </filter-select>
        
        <filter-select label="Destination Branch">
          <option value="all">All Branches</option>
        </filter-select>
        
        <date-range-picker label="Expected Delivery" />
      </filter-group>
    </filter-bar>
    
    <!-- Summary Stats -->
    <stats-bar>
      <stat-chip>
        <label>Total Transfers</label>
        <value>156</value>
      </stat-chip>
      <stat-chip color="blue">
        <label>In Transit</label>
        <value>12</value>
      </stat-chip>
      <stat-chip color="orange">
        <label>Pending</label>
        <value>8</value>
      </stat-chip>
      <stat-chip color="green">
        <label>This Month</label>
        <value>45</value>
      </stat-chip>
    </stats-bar>
    
    <!-- Transfers Table -->
    <card>
      <card-body padding="none">
        <data-table responsive="card" selection="multiple">
          <table-header>
            <column width="40px">
              <checkbox />
            </column>
            <column sortable="true">Transfer Code</column>
            <column>Source</column>
            <column>Destination</column>
            <column align="right">Items</column>
            <column sortable="true">Created Date</column>
            <column sortable="true">Expected Delivery</column>
            <column>Tracking</column>
            <column sortable="true">Status</column>
            <column>Actions</column>
          </table-header>
          
          <table-body>
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">TRF-2024-045</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Main Warehouse</text>
                  <text small="true" muted="true">New York, NY</text>
                </stack>
              </cell>
              <cell>
                <stack>
                  <text strong="true">East Warehouse</text>
                  <text small="true" muted="true">Boston, MA</text>
                </stack>
              </cell>
              <cell align="right">8</cell>
              <cell>Nov 7, 2024</cell>
              <cell>
                <stack>
                  <text>Nov 9, 2024</text>
                  <badge size="sm" color="blue">Today</badge>
                </stack>
              </cell>
              <cell>
                <link monospace="true" small="true">TRK-8877665544</link>
              </cell>
              <cell>
                <badge color="blue">In Transit</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost" title="View">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="ghost" title="Track">
                    <icon>map-pin</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>
                      <icon>package</icon>
                      Receive Transfer
                    </menu-item>
                    <menu-item>
                      <icon>printer</icon>
                      Print Transfer Doc
                    </menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">TRF-2024-046</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Main Warehouse</text>
                  <text small="true" muted="true">Zone A-R1-S3 → Zone B-R2-S1</text>
                </stack>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Main Warehouse</text>
                  <text small="true" muted="true">Internal Transfer</text>
                </stack>
              </cell>
              <cell align="right">15</cell>
              <cell>Nov 9, 2024</cell>
              <cell>
                <text>Nov 9, 2024</text>
              </cell>
              <cell>
                <text muted="true" small="true">N/A</text>
              </cell>
              <cell>
                <badge color="orange">Pending</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="primary" title="Start Transfer">
                    <icon>play</icon>
                  </button>
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <dropdown-menu>
                    <menu-item>Edit</menu-item>
                    <menu-item>Print</menu-item>
                    <menu-item color="danger">Cancel</menu-item>
                  </dropdown-menu>
                </button-group>
              </cell>
            </row>
            
            <row clickable="true">
              <cell>
                <checkbox />
              </cell>
              <cell>
                <link monospace="true" weight="bold">TRF-2024-044</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">East Warehouse</text>
                  <text small="true" muted="true">Boston, MA</text>
                </stack>
              </cell>
              <cell>
                <stack>
                  <text strong="true">West Warehouse</text>
                  <text small="true" muted="true">Chicago, IL</text>
                </stack>
              </cell>
              <cell align="right">22</cell>
              <cell>Nov 5, 2024</cell>
              <cell>Nov 8, 2024</cell>
              <cell>
                <link monospace="true" small="true">TRK-9988776655</link>
              </cell>
              <cell>
                <badge color="green">Completed</badge>
              </cell>
              <cell>
                <button-group compact="true">
                  <button size="sm" variant="ghost">
                    <icon>eye</icon>
                  </button>
                  <button size="sm" variant="ghost">
                    <icon>activity</icon>
                  </button>
                </button-group>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
        </data-table>
        
        <!-- Pagination -->
        <table-footer>
          <pagination>
            <page-info>Showing 1-20 of 156</page-info>
            <page-controls>
              <button disabled="true">Previous</button>
              <button active="true">1</button>
              <button>2</button>
              <button>3</button>
              <span>...</span>
              <button>8</button>
              <button>Next</button>
            </page-controls>
          </pagination>
        </table-footer>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 21. Transfer Order - Detail View

**Route:** `/inventory/transfers/:id`

**Purpose:** View and manage detailed transfer order

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>
      <link>Inventory</link> → <link>Transfers</link> → TRF-2024-045
    </breadcrumbs>
    <button-group>
      <button variant="outline">
        <icon>edit</icon>
        Edit
      </button>
      <button variant="outline">
        <icon>printer</icon>
        Print Transfer Doc
      </button>
      <button variant="primary">
        <icon>package</icon>
        Receive Transfer
      </button>
      <dropdown-menu>
        <menu-item>
          <icon>map-pin</icon>
          Track Shipment
        </menu-item>
        <menu-item>
          <icon>copy</icon>
          Duplicate Transfer
        </menu-item>
        <divider />
        <menu-item color="danger">
          <icon>x</icon>
          Cancel Transfer
        </menu-item>
      </dropdown-menu>
    </button-group>
  </page-header>
  
  <page-body layout="grid" gap="lg">
    <!-- Status Alert -->
    <alert-banner color="blue" span="full" dismissible="false">
      <icon>truck</icon>
      <content>
        <strong>In Transit:</strong> Expected delivery today at 3:00 PM
      </content>
      <action>
        <button variant="primary" size="sm">Track Shipment</button>
      </action>
    </alert-banner>
    
    <!-- Transfer Info -->
    <card span="2">
      <card-header>
        <title-group>
          <title>Transfer Order TRF-2024-045</title>
          <badge color="blue" size="lg">In Transit</badge>
        </title-group>
      </card-header>
      
      <card-body>
        <details-grid cols="3" cols-mobile="1">
          <detail-item>
            <label>Created By</label>
            <value>John Manager</value>
          </detail-item>
          
          <detail-item>
            <label>Created Date</label>
            <value>Nov 7, 2024 2:30 PM</value>
          </detail-item>
          
          <detail-item>
            <label>Total Items</label>
            <value strong="true">8 items</value>
          </detail-item>
          
          <detail-item>
            <label>Expected Delivery</label>
            <value>
              <stack>
                <text>Nov 9, 2024 3:00 PM</text>
                <badge size="sm" color="blue">Today</badge>
              </stack>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Actual Delivery</label>
            <value muted="true">Pending</value>
          </detail-item>
          
          <detail-item>
            <label>Tracking Number</label>
            <value>
              <link monospace="true">TRK-8877665544</link>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Shipped Quantity</label>
            <value>
              <progress-indicator>
                <value>8 / 8</value>
                <progress-bar value="100" color="green" />
              </progress-indicator>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Received Quantity</label>
            <value>
              <progress-indicator>
                <value>0 / 8</value>
                <progress-bar value="0" />
              </progress-indicator>
            </value>
          </detail-item>
          
          <detail-item>
            <label>Total Value</label>
            <value strong="true" size="lg">$8,450.00</value>
          </detail-item>
        </details-grid>
      </card-body>
    </card>
    
    <!-- Location Info -->
    <card span="1">
      <card-header>
        <title>Transfer Route</title>
      </card-header>
      <card-body>
        <transfer-route>
          <route-point>
            <route-icon color="blue">
              <icon>map-pin</icon>
            </route-icon>
            <route-details>
              <route-label>From</route-label>
              <route-location strong="true">Main Warehouse</route-location>
              <route-address small="true" muted="true">
                123 Industrial Ave<br/>
                New York, NY 10001
              </route-address>
            </route-details>
          </route-point>
          
          <route-connector>
            <icon>arrow-down</icon>
            <distance muted="true">215 miles</distance>
          </route-connector>
          
          <route-point>
            <route-icon color="green">
              <icon>map-pin</icon>
            </route-icon>
            <route-details>
              <route-label>To</route-label>
              <route-location strong="true">East Warehouse</route-location>
              <route-address small="true" muted="true">
                456 Commerce Blvd<br/>
                Boston, MA 02101
              </route-address>
            </route-details>
          </route-point>
        </transfer-route>
      </card-body>
    </card>
    
    <!-- Transfer Items -->
    <card span="full">
      <card-header>
        <title>Transfer Items</title>
      </card-header>
      
      <card-body padding="none">
        <data-table responsive="card">
          <table-header>
            <column>SKU Code</column>
            <column>Product</column>
            <column>Batch Number</column>
            <column align="right">Qty Requested</column>
            <column align="right">Qty Shipped</column>
            <column align="right">Qty Received</column>
            <column align="right">Unit Cost</column>
            <column align="right">Total Value</column>
            <column>Status</column>
          </table-header>
          
          <table-body>
            <row>
              <cell>
                <link monospace="true">SKU-1234-A</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Premium Widget Pro</text>
                  <text small="true" muted="true">Brand: TechCorp</text>
                </stack>
              </cell>
              <cell>
                <link monospace="true">B-2024-089</link>
              </cell>
              <cell align="right">20</cell>
              <cell align="right">
                <badge color="green">20</badge>
              </cell>
              <cell align="right">
                <badge color="gray">0</badge>
              </cell>
              <cell align="right">$125.00</cell>
              <cell align="right" strong="true">$2,500.00</cell>
              <cell>
                <badge color="blue">In Transit</badge>
              </cell>
            </row>
            
            <row>
              <cell>
                <link monospace="true">SKU-5678-B</link>
              </cell>
              <cell>
                <stack>
                  <text strong="true">Standard Gadget Plus</text>
                  <text small="true" muted="true">Brand: BuildCo</text>
                </stack>
              </cell>
              <cell>
                <link monospace="true">B-2024-052</link>
              </cell>
              <cell align="right">50</cell>
              <cell align="right">
                <badge color="green">50</badge>
              </cell>
              <cell align="right">
                <badge color="gray">0</badge>
              </cell>
              <cell align="right">$45.50</cell>
              <cell align="right" strong="true">$2,275.00</cell>
              <cell>
                <badge color="blue">In Transit</badge>
              </cell>
            </row>
            
            <!-- More rows... -->
          </table-body>
          
          <table-footer>
            <summary-row highlight="true">
              <cell colspan="7" align="right" strong="true" size="lg">Total Value:</cell>
              <cell align="right" strong="true" size="lg">$8,450.00</cell>
              <cell></cell>
            </summary-row>
          </table-footer>
        </data-table>
      </card-body>
    </card>
    
    <!-- Transfer Timeline -->
    <card span="full">
      <card-header>
        <title>Transfer History</title>
      </card-header>
      <card-body>
        <timeline>
          <timeline-item status="current">
            <icon color="blue">truck</icon>
            <content>
              <title>In Transit to Destination</title>
              <meta>Expected arrival: Nov 9, 2024 3:00 PM</meta>
            </content>
          </timeline-item>
          
          <timeline-item status="completed">
            <icon color="green">check-circle</icon>
            <content>
              <title>Items Shipped from Source</title>
              <meta>Nov 7, 2024 4:30 PM • Tracking: TRK-8877665544</meta>
              <details>
                <text small="true">All 8 items shipped, carrier: Express Freight</text>
              </details>
            </content>
          </timeline-item>
          
          <timeline-item status="completed">
            <icon color="blue">package</icon>
            <content>
              <title>Items Picked & Packed</title>
              <meta>Nov 7, 2024 3:15 PM • By: Mike Worker</meta>
            </content>
          </timeline-item>
          
          <timeline-item status="completed">
            <icon color="blue">file-text</icon>
            <content>
              <title>Transfer Order Created</title>
              <meta>Nov 7, 2024 2:30 PM • Created by: John Manager</meta>
              <details>
                <text small="true">Transfer from Main Warehouse to East Warehouse, 8 line items</text>
              </details>
            </content>
          </timeline-item>
        </timeline>
      </card-body>
    </card>
    
    <!-- Notes -->
    <card span="2">
      <card-header>
        <title>Transfer Notes</title>
      </card-header>
      <card-body>
        <comment-thread>
          <comment>
            <avatar>JM</avatar>
            <content>
              <author>John Manager</author>
              <time>Nov 7, 2024 2:35 PM</time>
              <text>Transferring excess inventory from Main to East Warehouse to meet increased demand in the Boston area. Priority shipment requested.</text>
            </content>
          </comment>
        </comment-thread>
      </card-body>
    </card>
    
    <!-- Documents -->
    <card span="1">
      <card-header>
        <title>Documents</title>
      </card-header>
      <card-body>
        <file-list>
          <file-item>
            <file-icon type="pdf" />
            <file-info>
              <file-name>transfer-manifest.pdf</file-name>
              <file-meta>180 KB</file-meta>
            </file-info>
            <file-actions>
              <button size="sm" variant="ghost">
                <icon>download</icon>
              </button>
              <button size="sm" variant="ghost">
                <icon>printer</icon>
              </button>
            </file-actions>
          </file-item>
        </file-list>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

This completes **Part 5: Inventory Adjustments & Transfers** (Sections 18-21)

---

## PART 6: WAREHOUSE OPERATIONS

## 22. Storage Zones - Overview

**Route:** `/warehouse/zones`

**Purpose:** Manage warehouse storage zones and locations

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Warehouse → Storage Zones</breadcrumbs>
    <button-group>
      <button variant="outline">
        <icon>map</icon>
        View Layout Map
      </button>
      <button variant="primary">
        <icon>plus</icon>
        Create Zone
      </button>
    </button-group>
  </page-header>
  
  <page-body>
    <!-- Branch Selector -->
    <filter-bar>
      <filter-group>
        <filter-select label="Branch" size="lg">
          <option value="main">Main Warehouse</option>
          <option value="east">East Warehouse</option>
          <option value="west">West Warehouse</option>
        </filter-select>
        
        <filter-select label="Zone Type">
          <option value="all">All Types</option>
          <option value="storage">Standard Storage</option>
          <option value="cold">Cold Storage</option>
          <option value="freezer">Freezer</option>
          <option value="hazmat">Hazmat</option>
          <option value="receiving">Receiving</option>
          <option value="shipping">Shipping</option>
        </filter-select>
        
        <search-input placeholder="Search zones..." />
      </filter-group>
    </filter-bar>
    
    <!-- Zone Statistics -->
    <kpi-row cols="5" gap="md">
      <kpi-card color="blue">
        <icon>map-pin</icon>
        <label>Total Zones</label>
        <value>48</value>
        <sublabel>Active locations</sublabel>
      </kpi-card>
      
      <kpi-card color="green">
        <icon>package</icon>
        <label>Occupied</label>
        <value>42</value>
        <progress-bar value="87.5" color="green" />
      </kpi-card>
      
      <kpi-card color="orange">
        <icon>alert-triangle</icon>
        <label>Near Capacity</label>
        <value>8</value>
        <sublabel>>&gt;90% full</sublabel>
      </kpi-card>
      
      <kpi-card color="gray">
        <icon>box</icon>
        <label>Empty</label>
        <value>6</value>
        <sublabel>Available</sublabel>
      </kpi-card>
      
      <kpi-card color="purple">
        <icon>maximize</icon>
        <label>Total Capacity</label>
        <value>15,420 m³</value>
      </kpi-card>
    </kpi-row>
    
    <!-- Zone Tree/Hierarchy View -->
    <card>
      <card-header>
        <title>Zone Hierarchy</title>
        <view-toggle>
          <button active="true">
            <icon>list</icon>
            Tree View
          </button>
          <button>
            <icon>grid</icon>
            Grid View
          </button>
        </view-toggle>
      </card-header>
      
      <card-body>
        <zone-tree>
          <!-- Zone A -->
          <tree-node level="1" expanded="true">
            <node-header>
              <node-icon>
                <icon>folder</icon>
              </node-icon>
              <node-title>Zone A - Main Storage</node-title>
              <node-badge>
                <badge color="blue">Standard</badge>
              </node-badge>
              <node-stats>
                <stat muted="true">12 rows • 85% occupied</stat>
              </node-stats>
              <node-actions>
                <button size="sm" variant="ghost">
                  <icon>edit</icon>
                </button>
                <button size="sm" variant="ghost">
                  <icon>map</icon>
                </button>
              </node-actions>
            </node-header>
            
            <tree-children>
              <!-- Row 1 -->
              <tree-node level="2" expanded="true">
                <node-header>
                  <node-icon>
                    <icon>folder</icon>
                  </node-icon>
                  <node-title>Row 1</node-title>
                  <node-stats>
                    <stat muted="true">8 shelves</stat>
                  </node-stats>
                </node-header>
                
                <tree-children>
                  <!-- Shelf 1 -->
                  <tree-node level="3">
                    <node-header>
                      <node-icon color="green">
                        <icon>box</icon>
                      </node-icon>
                      <node-title>Shelf 1 (A-R1-S1)</node-title>
                      <node-badge>
                        <badge color="green" size="sm">Active</badge>
                      </node-badge>
                      <node-stats>
                        <stat small="true">3.2 m³ • SKU-1234-A (50 units)</stat>
                      </node-stats>
                      <node-actions>
                        <button size="sm" variant="ghost" title="View Items">
                          <icon>eye</icon>
                        </button>
                        <button size="sm" variant="ghost" title="Edit">
                          <icon>edit</icon>
                        </button>
                      </node-actions>
                    </node-header>
                  </tree-node>
                  
                  <!-- Shelf 2 -->
                  <tree-node level="3">
                    <node-header>
                      <node-icon color="orange">
                        <icon>box</icon>
                      </node-icon>
                      <node-title>Shelf 2 (A-R1-S2)</node-title>
                      <node-badge>
                        <badge color="orange" size="sm">95% Full</badge>
                      </node-badge>
                      <node-stats>
                        <stat small="true">2.8 m³ • Multiple SKUs</stat>
                      </node-stats>
                      <node-actions>
                        <button size="sm" variant="ghost">
                          <icon>eye</icon>
                        </button>
                        <button size="sm" variant="ghost">
                          <icon>edit</icon>
                        </button>
                      </node-actions>
                    </node-header>
                  </tree-node>
                  
                  <!-- Shelf 3 -->
                  <tree-node level="3">
                    <node-header>
                      <node-icon color="green">
                        <icon>box</icon>
                      </node-icon>
                      <node-title>Shelf 3 (A-R1-S3)</node-title>
                      <node-badge>
                        <badge color="green" size="sm">Active</badge>
                      </node-badge>
                      <node-stats>
                        <stat small="true">4.1 m³ • SKU-5678-B (80 units)</stat>
                      </node-stats>
                      <node-actions>
                        <button size="sm" variant="ghost">
                          <icon>eye</icon>
                        </button>
                        <button size="sm" variant="ghost">
                          <icon>edit</icon>
                        </button>
                      </node-actions>
                    </node-header>
                  </tree-node>
                  
                  <!-- More shelves collapsed -->
                  <tree-node level="3" collapsed-indicator="true">
                    <node-header muted="true">
                      <text>+ 5 more shelves...</text>
                    </node-header>
                  </tree-node>
                </tree-children>
              </tree-node>
              
              <!-- More rows collapsed -->
              <tree-node level="2" collapsed-indicator="true">
                <node-header muted="true">
                  <text>+ 11 more rows...</text>
                </node-header>
              </tree-node>
            </tree-children>
          </tree-node>
          
          <!-- Zone B -->
          <tree-node level="1" expanded="false">
            <node-header>
              <node-icon>
                <icon>folder</icon>
              </node-icon>
              <node-title>Zone B - Cold Storage</node-title>
              <node-badge>
                <badge color="purple">Cold</badge>
              </node-badge>
              <node-stats>
                <stat muted="true">8 rows • 70% occupied</stat>
              </node-stats>
              <node-actions>
                <button size="sm" variant="ghost">
                  <icon>edit</icon>
                </button>
                <button size="sm" variant="ghost">
                  <icon>map</icon>
                </button>
              </node-actions>
            </node-header>
          </tree-node>
          
          <!-- Zone C -->
          <tree-node level="1" expanded="false">
            <node-header>
              <node-icon>
                <icon>folder</icon>
              </node-icon>
              <node-title>Zone C - Receiving Area</node-title>
              <node-badge>
                <badge color="blue">Receiving</badge>
              </node-badge>
              <node-stats>
                <stat muted="true">4 bays • 40% occupied</stat>
              </node-stats>
              <node-actions>
                <button size="sm" variant="ghost">
                  <icon>edit</icon>
                </button>
                <button size="sm" variant="ghost">
                  <icon>map</icon>
                </button>
              </node-actions>
            </node-header>
          </tree-node>
          
          <!-- More zones... -->
        </zone-tree>
      </card-body>
    </card>
    
    <!-- Capacity Utilization Chart -->
    <card>
      <card-header>
        <title>Capacity Utilization by Zone</title>
      </card-header>
      <card-body>
        <chart type="bar" orientation="horizontal" height="300px">
          <bar label="Zone A - Main" value="85" color="blue" />
          <bar label="Zone B - Cold" value="70" color="purple" />
          <bar label="Zone C - Receiving" value="40" color="green" />
          <bar label="Zone D - Shipping" value="35" color="orange" />
          <bar label="Zone E - Hazmat" value="60" color="red" />
          <bar label="Zone F - Freezer" value="92" color="orange" alert="true" />
        </chart>
      </card-body>
    </card>
  </page-body>
</screen>
```

---

## 23. Zone Layout Designer

**Route:** `/warehouse/zones/designer`

**Purpose:** Interactive tool to design and configure warehouse layout with pathfinding

**Layout:**

```html
<screen>
  <sidebar collapsible="true" />
  
  <page-header>
    <breadcrumbs>Warehouse → Zone Layout Designer</breadcrumbs>
    <button-group>
      <button variant="outline">
        <icon>upload</icon>
        Import Layout
      </button>
      <button variant="outline">
        <icon>download</icon>
        Export Layout
      </button>
      <button variant="primary">
        <icon>save</icon>
        Save Layout
      </button>
    </button-group>
  </page-header>
  
  <page-body layout="split" ratio="75-25">
    <!-- Main Canvas Area -->
    <main-panel>
      <card padding="none" height="full">
        <canvas-toolbar sticky="true">
          <toolbar-group>
            <tool-button active="true" title="Select">
              <icon>pointer</icon>
            </tool-button>
            <tool-button title="Pan">
              <icon>hand</icon>
            </tool-button>
          </toolbar-group>
          
          <divider vertical="true" />
          
          <toolbar-group>
            <tool-button title="Add Zone">
              <icon>square</icon>
            </tool-button>
            <tool-button title="Add Row">
              <icon>layout</icon>
            </tool-button>
            <tool-button title="Add Shelf">
              <icon>box</icon>
            </tool-button>
            <tool-button title="Add Path">
              <icon>git-commit</icon>
            </tool-button>
          </toolbar-group>
          
          <divider vertical="true" />
          
          <toolbar-group>
            <tool-button title="Draw Wall">
              <icon>minus</icon>
            </tool-button>
            <tool-button title="Draw Door">
              <icon>log-in</icon>
            </tool-button>
            <tool-button title="Draw Obstacle">
              <icon>octagon</icon>
            </tool-button>
          </toolbar-group>
          
          <divider vertical="true" />
          
          <toolbar-group>
            <tool-button title="Test Pathfinding">
              <icon>navigation</icon>
            </tool-button>
            <tool-button title="Show Grid">
              <icon>grid</icon>
            </tool-button>
            <tool-button title="Show Labels">
              <icon>tag</icon>
            </tool-button>
          </toolbar-group>
          
          <spacer />
          
          <toolbar-group>
            <zoom-control>
              <button size="sm">
                <icon>minus</icon>
              </button>
              <zoom-display>100%</zoom-display>
              <button size="sm">
                <icon>plus</icon>
              </button>
            </zoom-control>
          </toolbar-group>
        </canvas-toolbar>
        
        <canvas-area id="warehouse-canvas">
          <!-- Interactive Canvas -->
          <canvas-layer id="grid-layer">
            <!-- Grid lines -->
          </canvas-layer>
          
          <canvas-layer id="zones-layer">
            <!-- Zones, rows, shelves -->
            <zone-element id="zone-a" position="10,10" size="200,150" type="storage">
              <zone-label>Zone A</zone-label>
              <zone-rows>
                <row-element position="15,15" size="190,20">
                  <shelf-element position="15,15" size="18,18" status="occupied">
                    <shelf-label>A-R1-S1</shelf-label>
                  </shelf-element>
                  <shelf-element position="35,15" size="18,18" status="occupied">
                    <shelf-label>A-R1-S2</shelf-label>
                  </shelf-element>
                  <shelf-element position="55,15" size="18,18" status="empty">
                    <shelf-label>A-R1-S3</shelf-label>
                  </shelf-element>
                  <!-- More shelves -->
                </row-element>
                <!-- More rows -->
              </zone-rows>
            </zone-element>
            
            <zone-element id="zone-b" position="220,10" size="150,150" type="cold">
              <zone-label>Zone B - Cold</zone-label>
            </zone-element>
          </canvas-layer>
          
          <canvas-layer id="paths-layer">
            <!-- Walkways and paths -->
            <path-element points="0,80 400,80" width="3" type="main-aisle" />
            <path-element points="100,0 100,200" width="2" type="cross-aisle" />
          </canvas-layer>
          
          <canvas-layer id="obstacles-layer">
            <!-- Walls, doors, obstacles -->
            <wall-element points="0,0 400,0" />
            <door-element position="200,0" size="10" />
          </canvas-layer>
          
          <canvas-layer id="pathfinding-layer">
            <!-- Pathfinding visualization -->
            <path-route points="..." color="blue" animated="true" />
            <waypoint position="50,50" type="start" />
            <waypoint position="300,120" type="end" />
          </canvas-layer>
        </canvas-area>
        
        <canvas-status-bar>
          <status-item>
            <icon>mouse-pointer</icon>
            <text>X: 156, Y: 234</text>
          </status-item>
          <status-item>
            <icon>layers</icon>
            <text>48 zones • 384 locations</text>
          </status-item>
          <status-item>
            <icon>check-circle</icon>
            <text color="green">All paths valid</text>
          </status-item>
        </canvas-status-bar>
      </card>
    </main-panel>
    
    <!-- Right Sidebar - Properties & Tools -->
    <side-panel>
      <!-- Layer Control -->
      <card>
        <card-header>
          <title>Layers</title>
        </card-header>
        <card-body padding="sm">
          <layer-list>
            <layer-item>
              <checkbox checked="true" />
              <layer-icon>
                <icon>square</icon>
              </layer-icon>
              <layer-name>Zones</layer-name>
              <layer-actions>
                <button size="sm" variant="ghost">
                  <icon>eye</icon>
                </button>
              </layer-actions>
            </layer-item>
            
            <layer-item>
              <checkbox checked="true" />
              <layer-icon>
                <icon>git-commit</icon>
              </layer-icon>
              <layer-name>Paths</layer-name>
              <layer-actions>
                <button size="sm" variant="ghost">
                  <icon>eye</icon>
                </button>
              </layer-actions>
            </layer-item>
            
            <layer-item>
              <checkbox checked="true" />
              <layer-icon>
                <icon>minus</icon>
              </layer-icon>
              <layer-name>Walls</layer-name>
              <layer-actions>
                <button size="sm" variant="ghost">
                  <icon>eye</icon>
                </button>
              </layer-actions>
            </layer-item>
            
            <layer-item>
              <checkbox checked="false" />
              <layer-icon>
                <icon>grid</icon>
              </layer-icon>
              <layer-name>Grid</layer-name>
              <layer-actions>
                <button size="sm" variant="ghost">
                  <icon>eye-off</icon>
                </button>
              </layer-actions>
            </layer-item>
          </layer-list>
        </card-body>
      </card>
      
      <!-- Properties Panel -->
      <card conditional="has-selection">
        <card-header>
          <title>Properties</title>
          <badge>Zone A-R1-S3</badge>
        </card-header>
        <card-body>
          <form-section>
            <form-label>Location Code</form-label>
            <input type="text" value="A-R1-S3" readonly="true" />
          </form-section>
          
          <form-section>
            <form-label>Zone Type</form-label>
            <select>
              <option>Standard Storage</option>
              <option>Cold Storage</option>
              <option>Freezer</option>
              <option>Hazmat</option>
            </select>
          </form-section>
          
          <form-section>
            <form-label>Dimensions</form-label>
            <input-group>
              <input type="number" placeholder="Width" value="2.5" />
              <span>×</span>
              <input type="number" placeholder="Height" value="3.0" />
              <span>m</span>
            </input-group>
          </form-section>
          
          <form-section>
            <form-label>Capacity (m³)</form-label>
            <input type="number" value="7.5" step="0.1" />
          </form-section>
          
          <form-section>
            <form-label>Max Weight (kg)</form-label>
            <input type="number" value="500" />
          </form-section>
          
          <form-section>
            <form-label>Accessibility</form-label>
            <checkbox-group>
              <checkbox checked="true">
                <label>Forklift Access</label>
              </checkbox>
              <checkbox checked="false">
                <label>Pallet Jack Only</label>
              </checkbox>
              <checkbox checked="true">
                <label>Hand Picking</label>
              </checkbox>
            </checkbox-group>
          </form-section>
          
          <form-section>
            <form-label>Attributes</form-label>
            <tag-input>
              <tag>Temperature Controlled</tag>
              <tag>High Ceiling</tag>
              <tag>Ground Level</tag>
            </tag-input>
          </form-section>
          
          <button-group layout="stack" margin-top="md">
            <button variant="primary" size="sm" fullwidth="true">
              Apply Changes
            </button>
            <button variant="outline" size="sm" fullwidth="true" color="danger">
              Delete Location
            </button>
          </button-group>
        </card-body>
      </card>
      
      <!-- Pathfinding Tool -->
      <card>
        <card-header>
          <title>Pathfinding Test</title>
        </card-header>
        <card-body>
          <form-section>
            <form-label>Start Location</form-label>
            <select>
              <option>Select location...</option>
              <option>A-R1-S1</option>
              <option>A-R1-S2</option>
              <option>A-R1-S3</option>
            </select>
          </form-section>
          
          <form-section>
            <form-label>End Location</form-label>
            <select>
              <option>Select location...</option>
              <option>B-R2-S4</option>
              <option>C-R1-S2</option>
            </select>
          </form-section>
          
          <button variant="primary" size="sm" fullwidth="true">
            <icon>navigation</icon>
            Calculate Path
          </button>
          
          <result-panel margin-top="md" conditional="has-result">
            <result-item>
              <label>Distance</label>
              <value strong="true">87 meters</value>
            </result-item>
            <result-item>
              <label>Estimated Time</label>
              <value strong="true">2.5 minutes</value>
            </result-item>
            <result-item>
              <label>Waypoints</label>
              <value>8</value>
            </result-item>
          </result-panel>
        </card-body>
      </card>
      
      <!-- Quick Stats -->
      <card>
        <card-header>
          <title>Layout Stats</title>
        </card-header>
        <card-body>
          <stat-list compact="true">
            <stat-item>
              <label>Total Zones</label>
              <value>6</value>
            </stat-item>
            <stat-item>
              <label>Storage Locations</label>
              <value>384</value>
            </stat-item>
            <stat-item>
              <label>Total Capacity</label>
              <value>2,880 m³</value>
            </stat-item>
            <stat-item>
              <label>Path Length</label>
              <value>1,245 m</value>
            </stat-item>
          </stat-list>
        </card-body>
      </card>
    </side-panel>
  </page-body>
</screen>
```

---

## 24. Work Sessions Monitor - Real-time

**Route:** `/warehouse/sessions/monitor`

**Purpose:** Real-time monitoring of all active work sessions

**Layout:**

```html
<screen>
  <sidebar />
  
  <page-header>
    <breadcrumbs>Warehouse → Work Sessions Monitor</breadcrumbs>
    <badge color="green" pulse="true" size="lg">
      <icon>activity</icon>
      Live Updates
    </badge>
  </page-header>
  
  <page-body>
    <!-- Filter Bar -->
    <filter-bar>
      <filter-group>
        <filter-select label="Session Type">
          <option value="all">All Types</option>
          <option value="receiving">Receiving</option>
          <option value="picking">Picking</option>
          <option value="packing">Packing</option>
          <option value="transfer">Transfer</option>
          <option value="cycle-count">Cycle Count</option>
        </filter-select>
        
        <filter-select label="Status">
          <option value="active">Active Only</option>
          <option value="all">All Statuses</option>
          <option value="pending">Pending</option>
          <option value="paused">Paused</option>
          <option value="completed">Completed</option>
        </filter-select>
        
        <filter-select label="Branch">
          <option value="all">All Branches</option>
        </filter-select>
        
        <filter-select label="Worker">
          <option value="all">All Workers</option>
        </filter-select>
      </filter-group>
    </filter-bar>
    
    <!-- Real-time Stats -->
    <kpi-row cols="5" gap="md" auto-refresh="true">
      <kpi-card color="green">
        <icon>activity</icon>
        <label>Active Sessions</label>
        <value>8</value>
        <badge size="sm" color="green" pulse="true">Live</badge>
      </kpi-card>
      
      <kpi-card color="blue">
        <icon>users</icon>
        <label>Workers Active</label>
        <value>12</value>
      </kpi-card>
      
      <kpi-card color="purple">
        <icon>package</icon>
        <label>Items Processed Today</label>
        <value>1,456</value>
        <trend>+12% vs yesterday</trend>
      </kpi-card>
      
      <kpi-card color="orange">
        <icon>clock</icon>
        <label>Avg Session Time</label>
        <value>18 min</value>
      </kpi-card>
      
      <kpi-card color="green">
        <icon>check-circle</icon>
        <label>Accuracy Rate</label>
        <value>98.5%</value>
      </kpi-card>
    </kpi-row>
    
    <!-- Active Sessions Grid -->
    <grid-layout cols="2" cols-tablet="1" gap="md">
      <!-- Session Card 1 -->
      <session-card status="active" priority="high">
        <session-header>
          <session-title>
            <session-type-icon type="receiving" color="blue">
              <icon>package</icon>
            </session-type-icon>
            <session-info>
              <session-code monospace="true">RCV-2024-034</session-code>
              <session-type>Receiving Session</session-type>
            </session-info>
          </session-title>
          <session-status>
            <badge color="green" pulse="true">Active</badge>
            <timer live="true">00:45:32</timer>
          </session-status>
        </session-header>
        
        <session-body>
          <session-details>
            <detail-row>
              <icon>user</icon>
              <label>Worker</label>
              <value>
                <link>John Worker</link>
              </value>
            </detail-row>
            
            <detail-row>
              <icon>clipboard</icon>
              <label>Order</label>
              <value>
                <link>PO-2024-157</link>
              </value>
            </detail-row>
            
            <detail-row>
              <icon>building</icon>
              <label>Branch</label>
              <value>Main Warehouse</value>
            </detail-row>
          </session-details>
          
          <progress-section margin-top="md">
            <progress-label>
              <text>Progress</text>
              <text strong="true">22 / 35 items</text>
            </progress-label>
            <progress-bar value="63" size="md" animated="true" color="blue">
              63%
            </progress-bar>
          </progress-section>
          
          <metrics-row margin-top="sm">
            <metric-chip size="sm">
              <icon>clock</icon>
              <value>2.1 min/item</value>
            </metric-chip>
            <metric-chip size="sm">
              <icon>zap</icon>
              <value>100% accuracy</value>
            </metric-chip>
          </metrics-row>
        </session-body>
        
        <session-footer>
          <button-group>
            <button size="sm" variant="outline">
              <icon>eye</icon>
              View Details
            </button>
            <button size="sm" variant="outline">
              <icon>message-circle</icon>
              Message Worker
            </button>
          </button-group>
        </session-footer>
      </session-card>
      
      <!-- Session Card 2 -->
      <session-card status="active" priority="urgent">
        <session-header>
          <session-title>
            <session-type-icon type="picking" color="green">
              <icon>shopping-bag</icon>
            </session-type-icon>
            <session-info>
              <session-code monospace="true">PICK-2024-078</session-code>
              <session-type>Picking Session</session-type>
            </session-info>
          </session-title>
          <session-status>
            <badge color="green" pulse="true">Active</badge>
            <badge color="red">Urgent</badge>
            <timer live="true">00:12:18</timer>
          </session-status>
        </session-header>
        
        <session-body>
          <alert-box color="red" size="sm" margin-bottom="sm">
            <icon>alert-circle</icon>
            <text small="true">Order must ship by 4:00 PM today</text>
          </alert-box>
          
          <session-details>
            <detail-row>
              <icon>user</icon>
              <label>Worker</label>
              <value>
                <link>Sarah Worker</link>
              </value>
            </detail-row>
            
            <detail-row>
              <icon>send</icon>
              <label>Order</label>
              <value>
                <link>OUT-2024-089</link>
              </value>
            </detail-row>
            
            <detail-row>
              <icon>building</icon>
              <label>Branch</label>
              <value>Main Warehouse</value>
            </detail-row>
          </session-details>
          
          <progress-section margin-top="md">
            <progress-label>
              <text>Progress</text>
              <text strong="true">4 / 12 items</text>
            </progress-label>
            <progress-bar value="33" size="md" animated="true" color="green">
              33%
            </progress-bar>
          </progress-section>
          
          <metrics-row margin-top="sm">
            <metric-chip size="sm">
              <icon>clock</icon>
              <value>3.0 min/item</value>
            </metric-chip>
            <metric-chip size="sm">
              <icon>zap</icon>
              <value>100% accuracy</value>
            </metric-chip>
          </metrics-row>
        </session-body>
        
        <session-footer>
          <button-group>
            <button size="sm" variant="outline">
              <icon>eye</icon>
              View Details
            </button>
            <button size="sm" variant="outline">
              <icon>message-circle</icon>
              Message Worker
            </button>
          </button-group>
        </session-footer>
      </session-card>
      
      <!-- Session Card 3 - Paused -->
      <session-card status="paused">
        <session-header>
          <session-title>
            <session-type-icon type="packing" color="orange">
              <icon>box</icon>
            </session-type-icon>
            <session-info>
              <session-code monospace="true">PACK-2024-052</session-code>
              <session-type>Packing Session</session-type>
            </session-info>
          </session-title>
          <session-status>
            <badge color="orange">Paused</badge>
            <timer live="false">00:28:45</timer>
          </session-status>
        </session-header>
        
        <session-body>
          <session-details>
            <detail-row>
              <icon>user</icon>
              <label>Worker</label>
              <value>
                <link>Mike Worker</link>
              </value>
            </detail-row>
            
            <detail-row>
              <icon>send</icon>
              <label>Order</label>
              <value>
                <link>OUT-2024-088</link>
              </value>
            </detail-row>
            
            <detail-row>
              <icon>clock</icon>
              <label>Paused</label>
              <value>5 minutes ago</value>
            </detail-row>
          </session-details>
          
          <progress-section margin-top="md">
            <progress-label>
              <text>Progress</text>
              <text strong="true">15 / 24 items</text>
            </progress-label>
            <progress-bar value="63" size="md" color="orange">
              63%
            </progress-bar>
          </progress-section>
        </session-body>
        
        <session-footer>
          <button-group>
            <button size="sm" variant="primary">
              <icon>play</icon>
              Resume
            </button>
            <button size="sm" variant="outline">
              <icon>eye</icon>
              View
            </button>
          </button-group>
        </session-footer>
      </session-card>
      
      <!-- Session Card 4 -->
      <session-card status="active">
        <session-header>
          <session-title>
            <session-type-icon type="transfer" color="purple">
              <icon>move</icon>
            </session-type-icon>
            <session-info>
              <session-code monospace="true">TRF-2024-046</session-code>
              <session-type>Transfer Session</session-type>
            </session-info>
          </session-title>
          <session-status>
            <badge color="green" pulse="true">Active</badge>
            <timer live="true">00:15:22</timer>
          </session-status>
        </session-header>
        
        <session-body>
          <session-details>
            <detail-row>
              <icon>user</icon>
              <label>Worker</label>
              <value>
                <link>Bob Worker</link>
              </value>
            </detail-row>
            
            <detail-row>
              <icon>move</icon>
              <label>Route</label>
              <value>A-R1-S3 → B-R2-S1</value>
            </detail-row>
            
            <detail-row>
              <icon>building</icon>
              <label>Type</label>
              <value>Internal Transfer</value>
            </detail-row>
          </session-details>
          
          <progress-section margin-top="md">
            <progress-label>
              <text>Progress</text>
              <text strong="true">8 / 15 items</text>
            </progress-label>
            <progress-bar value="53" size="md" animated="true" color="purple">
              53%
            </progress-bar>
          </progress-section>
          
          <metrics-row margin-top="sm">
            <metric-chip size="sm">
              <icon>clock</icon>
              <value>1.9 min/item</value>
            </metric-chip>
          </metrics-row>
        </session-body>
        
        <session-footer>
          <button-group>
            <button size="sm" variant="outline">
              <icon>eye</icon>
              View Details
            </button>
            <button size="sm" variant="outline">
              <icon>map</icon>
              Show Route
            </button>
          </button-group>
        </session-footer>
      </session-card>
      
      <!-- More session cards... -->
    </grid-layout>
    
    <!-- Session Activity Timeline -->
    <card>
      <card-header>
        <title>Recent Session Activity</title>
        <badge color="green" pulse="true">Live</badge>
      </card-header>
      <card-body>
        <activity-timeline real-time="true">
          <activity-item type="completed">
            <activity-icon color="green">
              <icon>check-circle</icon>
            </activity-icon>
            <activity-content>
              <activity-title>
                <link>RCV-2024-033</link> completed successfully
              </activity-title>
              <activity-meta>
                John Worker • 2 minutes ago • 34 items • 42 min duration • 100% accuracy
              </activity-meta>
            </activity-content>
          </activity-item>
          
          <activity-item type="started">
            <activity-icon color="blue">
              <icon>play</icon>
            </activity-icon>
            <activity-content>
              <activity-title>
                <link>PICK-2024-078</link> started
              </activity-title>
              <activity-meta>
                Sarah Worker • 5 minutes ago • OUT-2024-089 • 12 items
              </activity-meta>
            </activity-content>
          </activity-item>
          
          <activity-item type="paused">
            <activity-icon color="orange">
              <icon>pause</icon>
            </activity-icon>
            <activity-content>
              <activity-title>
                <link>PACK-2024-052</link> paused
              </activity-title>
              <activity-meta>
                Mike Worker • 8 minutes ago • Break time
              </activity-meta>
            </activity-content>
          </activity-item>
          
          <activity-item type="issue">
            <activity-icon color="red">
              <icon>alert-triangle</icon>
            </activity-icon>
            <activity-content>
              <activity-title>
                Issue reported in <link>RCV-2024-034</link>
              </activity-title>
              <activity-meta>
                John Worker • 15 minutes ago • Quantity mismatch on SKU-1234-A
              </activity-meta>
            </activity-content>
          </activity-item>
          
          <activity-item type="completed">
            <activity-icon color="green">
              <icon>check-circle</icon>
            </activity-icon>
            <activity-content>
              <activity-title>
                <link>PICK-2024-077</link> completed successfully
              </activity-title>
              <activity-meta>
                Bob Worker • 20 minutes ago • 18 items • 28 min duration • 98.5% accuracy
              </activity-meta>
            </activity-content>
          </activity-item>
        </activity-timeline>
      </card-body>
    </card>
    
    <!-- Performance Charts -->
    <grid-layout cols="2" cols-tablet="1">
      <card>
        <card-header>
          <title>Sessions by Hour (Today)</title>
        </card-header>
        <card-body>
          <chart type="bar" height="200px">
            <x-axis label="Hour" />
            <y-axis label="Sessions" />
            <bar-series label="Completed" color="green" data="[8,12,15,18,14,10,9,11]" />
            <bar-series label="Active" color="blue" data="[2,3,2,4,3,2,1,2]" />
          </chart>
        </card-body>
      </card>
      
      <card>
        <card-header>
          <title>Average Session Time by Type</title>
        </card-header>
        <card-body>
          <chart type="donut">
            <segment label="Receiving" value="42" color="blue" />
            <segment label="Picking" value="28" color="green" />
            <segment label="Packing" value="18" color="orange" />
            <segment label="Transfer" value="15" color="purple" />
          </chart>
        </card-body>
      </card>
    </grid-layout>
  </page-body>
</screen>
```

---

This completes **Part 6: Warehouse Operations** (Sections 22-24)

---

## PART 7: MASTER DATA

## 25. Products Management

**Route:** `/master-data/products`
**Description:** Comprehensive product catalog management including product creation, editing, categorization, and variant management. Supports product attributes, specifications, images, and lifecycle status.

## 26. SKUs Management

**Route:** `/master-data/skus`
**Description:** SKU (Stock Keeping Unit) management linked to products. Handles SKU variants, barcodes, packaging information, dimensions, weight, and storage requirements. Supports batch and serial number tracking configuration.

## 27. Product Categories

**Route:** `/master-data/categories`
**Description:** Hierarchical category tree management for organizing products. Supports unlimited nesting levels using ltree structure, drag-and-drop reorganization, and category attributes inheritance.

## 28. Brands Management

**Route:** `/master-data/brands`
**Description:** Brand registry with manufacturer information, contact details, and associated products. Tracks brand performance metrics and supplier relationships.

## 29. Suppliers Management

**Route:** `/master-data/suppliers`
**Description:** Supplier database with contact information, payment terms, lead times, and performance ratings. Manages supplier-product relationships, pricing agreements, and delivery schedules.

## 30. Units of Measure

**Route:** `/master-data/units`
**Description:** Standard and custom units of measure configuration. Supports conversion ratios between units (e.g., box to pieces, pallet to boxes) for inventory calculations.

---

This completes **Part 7: Master Data** (Sections 25-30)

---

## PART 8: REPORTS & ANALYTICS

## 31. Dashboard & Analytics Overview

**Route:** `/reports/dashboard`
**Description:** Executive analytics dashboard with key performance indicators, trend analysis, and customizable widgets. Features demand forecasting visualizations, turnover rates, and comparative period analysis.

## 32. Inventory Reports

**Route:** `/reports/inventory`
**Description:** Comprehensive inventory reporting including stock levels, aging analysis, ABC classification, slow-moving items, and reorder recommendations. Supports scheduled report generation and export.

## 33. Inbound Operations Reports

**Route:** `/reports/inbound`
**Description:** Purchase order fulfillment tracking, receiving performance metrics, supplier delivery accuracy, and lead time analysis. Includes variance reports and quality metrics.

## 34. Outbound Operations Reports

**Route:** `/reports/outbound`
**Description:** Order fulfillment statistics, picking accuracy, packing efficiency, shipping performance, and on-time delivery metrics. Features backorder analysis and customer service level reports.

## 35. Work Session Analytics

**Route:** `/reports/sessions`
**Description:** Worker productivity analysis, session duration tracking, accuracy rates, and performance comparisons. Supports individual and team performance dashboards with trend analysis.

## 36. Demand Forecasting

**Route:** `/reports/forecasting`
**Description:** AI-powered demand prediction using historical data, seasonality patterns, and trend analysis. Provides forecasted stock requirements, reorder point recommendations, and scenario planning tools.

## 37. Financial Reports

**Route:** `/reports/financial`
**Description:** Inventory valuation reports, cost analysis, carrying costs, and inventory turnover financial metrics. Supports FIFO/LIFO calculation methods and period-over-period comparisons.

## 38. Custom Report Builder

**Route:** `/reports/custom`
**Description:** Flexible report builder with drag-and-drop field selection, filter configuration, grouping/aggregation options, and visualization choices. Supports saving report templates and scheduled execution.

---

This completes **Part 8: Reports & Analytics** (Sections 31-38)

---

## PART 9: ADMINISTRATION

## 39. User Management

**Route:** `/admin/users`
**Description:** Complete user account management including creation, editing, role assignment, and permission configuration. Supports user status management (active/inactive), password resets, and login history tracking.

## 40. Roles & Permissions

**Route:** `/admin/roles`
**Description:** Role-based access control configuration with granular permissions management. Supports creating custom roles, cloning existing roles, and assigning feature-level and data-level permissions (view, create, edit, delete).

## 41. Branch Management

**Route:** `/admin/branches`
**Description:** Warehouse branch configuration including location details, operating hours, capacity settings, and zone configurations. Manages branch hierarchies and inter-branch transfer rules.

## 42. Organization Settings

**Route:** `/admin/organization`
**Description:** Organization-level configuration including company profile, address, contact information, business rules, and system preferences. Multi-tenant settings for organizations with multiple branches.

## 43. System Lookups

**Route:** `/admin/lookups`
**Description:** Configurable dropdown values and reference data management. Includes product attributes, adjustment reasons, transfer types, order statuses, and other system-wide lookup tables.

## 44. Audit Logs

**Route:** `/admin/audit-logs`
**Description:** Comprehensive audit trail viewer showing all system activities, user actions, data changes, and access logs. Supports filtering by user, action type, date range, and affected entities. Includes change history with before/after values.

## 45. System Configuration

**Route:** `/admin/system`
**Description:** System-wide settings including email notifications, barcode formats, number sequences (PO numbers, order numbers), integration settings, and feature toggles.

## 46. Data Import/Export

**Route:** `/admin/import-export`
**Description:** Bulk data import/export tools supporting CSV/Excel formats. Includes templates for products, SKUs, inventory, and master data. Features validation, error reporting, and rollback capabilities.

---

This completes **Part 9: Administration** (Sections 39-46)

---

## DESIGN COMPLETE

Total Screens Designed: 46

This completes the comprehensive UI/UX design for the Warehouse Management System, covering:

- ✅ Dashboard Screens (4 role-specific views)
- ✅ Inbound Operations (5 screens)
- ✅ Outbound Operations (4 screens)
- ✅ Inventory Management (4 screens)
- ✅ Inventory Adjustments & Transfers (4 screens)
- ✅ Warehouse Operations (3 screens)
- ✅ Master Data (6 screens)
- ✅ Reports & Analytics (8 screens)
- ✅ Administration (8 screens)

All screens follow consistent design patterns with:

- Responsive layouts (desktop, tablet, mobile)
- Permission-based navigation
- Mobile-first worker interfaces
- Real-time updates where applicable
- Comprehensive filtering and search
- Batch operations support
- Audit trail integration
